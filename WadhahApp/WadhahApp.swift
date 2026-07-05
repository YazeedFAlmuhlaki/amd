import SwiftUI

// MARK: - App Entry + Navigation
// The whole app is forced RTL for Arabic.

enum Route: Hashable {
    case history
    case chat(ChatScenario?)
}

@main
struct WadhahApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.layoutDirection, .rightToLeft)
                .environment(\.locale, Locale(identifier: "ar_SA"))
                .preferredColorScheme(.dark)
        }
    }
}

struct RootView: View {
    @StateObject private var store = BankStore()

    var body: some View {
        NavigationStack {
            DashboardView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .history:
                        TransactionHistoryView()
                    case .chat(let scenario):
                        WadhahChatView(scenario: scenario)
                    }
                }
        }
        .environmentObject(store)
        .tint(WadhahTheme.accent)
    }
}

#Preview("Dashboard") {
    RootView()
        .environment(\.layoutDirection, .rightToLeft)
}

#Preview("Chat — Apple") {
    NavigationStack {
        WadhahChatView(scenario: .appleSubscription)
    }
    .environment(\.layoutDirection, .rightToLeft)
    .preferredColorScheme(.dark)
}
