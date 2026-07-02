import SwiftUI

// MARK: - Screen 2: Transaction History (سجل العمليات)

struct TransactionHistoryView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(DummyData.recentTransactions) { transaction in
                    if let scenario = transaction.scenario {
                        NavigationLink(value: Route.chat(scenario)) {
                            TransactionRow(transaction: transaction, showsWadhahPill: true)
                        }
                        .buttonStyle(.plain)
                    } else {
                        // No scripted scenario — pill still shown as the universal entry point.
                        TransactionRow(transaction: transaction, showsWadhahPill: true)
                    }
                }
            }
            .padding(16)
        }
        .background(WadhahTheme.background)
        .navigationTitle("سجل العمليات")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(WadhahTheme.background, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}
