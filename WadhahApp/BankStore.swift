import Foundation
import SwiftUI

// MARK: - Swift mirror of the KMP shared module
// BankStore mirrors `com.wadhah.shared.data.MockBankRepository` and WadhahChatEngine
// mirrors `com.wadhah.shared.chat.WadhahAssistant`. The shared data is identical; the
// shapes differ slightly (the KMP side has no systemIcon and uses scenarioId strings),
// so wiring in WadhahShared.xcframework needs a thin adapter mapping its types onto
// Transaction/ChatScenario — see the README's "Building the KMP framework" section.

struct Account {
    let holderFirstName: String
    let balanceSAR: Double
    let cardSuffix: String
    let cardExpiry: String
    let loyaltyPoints: Int

    /// Western digits with grouping, matching the design (e.g. "18,240.75").
    var formattedBalance: String {
        Self.decimalFormatter.string(from: NSNumber(value: balanceSAR)) ?? "\(balanceSAR)"
    }

    /// e.g. "1,330"
    var formattedPoints: String {
        Self.integerFormatter.string(from: NSNumber(value: loyaltyPoints)) ?? "\(loyaltyPoints)"
    }

    private static let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()

    private static let integerFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
}

@MainActor
final class BankStore: ObservableObject {
    @Published private(set) var account = Account(
        holderFirstName: "أنس",
        balanceSAR: 18_240.75,
        cardSuffix: "4821",
        cardExpiry: "08/28",
        loyaltyPoints: 1_330
    )
    @Published private(set) var recentTransactions: [Transaction] = DummyData.recentTransactions

    /// Home shows only the first 3.
    var latestTransactions: [Transaction] {
        Array(recentTransactions.prefix(3))
    }
}

// MARK: - Chat

struct WadhahChatMessage: Identifiable, Equatable {
    enum Role { case user, assistant }

    let id = UUID()
    let role: Role
    var text: String
    var actions: [String] = []
    var isTyping = false
}

@MainActor
final class WadhahChatEngine: ObservableObject {
    @Published private(set) var messages: [WadhahChatMessage] = []

    init(scenario: ChatScenario?) {
        if let scenario {
            messages = [
                WadhahChatMessage(role: .user, text: scenario.userMessage),
                WadhahChatMessage(
                    role: .assistant,
                    text: scenario.assistantMessage,
                    actions: [scenario.actions.primary, scenario.actions.secondary]
                )
            ]
        } else {
            messages = [
                WadhahChatMessage(
                    role: .assistant,
                    text: "هلا! أنا وضّح 👋 اسألني عن أي عملية أو رسوم أو اشتراك في حسابك."
                )
            ]
        }
    }

    func send(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        messages.append(WadhahChatMessage(role: .user, text: trimmed))

        let typing = WadhahChatMessage(role: .assistant, text: "", isTyping: true)
        messages.append(typing)

        Task { [weak self] in
            try? await Task.sleep(nanoseconds: 1_100_000_000)
            guard let self,
                  let index = self.messages.firstIndex(where: { $0.id == typing.id }) else { return }
            self.messages[index].isTyping = false
            self.messages[index].text = "استلمت سؤالك 👌 هذي نسخة تجريبية من وضّح — في التطبيق الفعلي بجاوبك من بيانات حسابك وسجل عملياتك مباشرة."
        }
    }
}
