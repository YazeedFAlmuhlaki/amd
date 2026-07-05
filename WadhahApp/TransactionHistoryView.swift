import SwiftUI

// MARK: - Screen 2: Transaction History (سجل العمليات)

struct TransactionHistoryView: View {
    @EnvironmentObject private var store: BankStore

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(store.recentTransactions) { transaction in
                    // Every row opens Wadhah; unscripted ones get the generic assistant greeting.
                    NavigationLink(value: Route.chat(transaction.scenario)) {
                        TransactionRow(transaction: transaction, showsWadhahPill: true)
                    }
                    .buttonStyle(.plain)
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
