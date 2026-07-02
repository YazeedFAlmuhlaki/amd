import SwiftUI

// MARK: - Shared Components

/// Soft orange pill with the Wadhah logo — the Wadhah entry point shown under amounts.
struct WadhahPill: View {
    var body: some View {
        HStack(spacing: 5) {
            Image("Wad")
                .resizable()
                .scaledToFill()
                .frame(width: 22, height: 22)
                .clipShape(Circle())
            Text("وضح")
                .font(.system(size: 13, weight: .bold))
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 14)
        .padding(.vertical, 7)
        .background(Color(hex: 0xD17D58), in: Capsule())
    }
}

/// A single transaction row (used on Home + History).
struct TransactionRow: View {
    let transaction: Transaction
    var showsWadhahPill = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                Image(systemName: transaction.systemIcon)
                    .font(.system(size: 16))
                    .foregroundStyle(WadhahTheme.accent)
                    .frame(width: 40, height: 40)
                    .background(WadhahTheme.cardElevated, in: RoundedRectangle(cornerRadius: 12))

                VStack(alignment: .leading, spacing: 3) {
                    Text(transaction.merchant)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(WadhahTheme.textPrimary)
                    Text("\(transaction.category) · \(transaction.timestamp)")
                        .font(.system(size: 11))
                        .foregroundStyle(WadhahTheme.textSecondary)
                }

                Spacer()

                HStack(spacing: 6) {
                    Text(transaction.formattedAmount)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(WadhahTheme.textPrimary)
                    // "chevron.left" ثابت عشان يأشر يسار دايمًا حتى مع اتجاه RTL
                    Image(systemName: "chevron.left")
                        .font(.system(size: 11))
                        .foregroundStyle(WadhahTheme.textSecondary)
                }
            }

            if showsWadhahPill {
                // trailing مع اتجاه RTL = أسفل يسار الكرت مثل التصميم
                WadhahPill()
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(14)
        .background(WadhahTheme.card, in: RoundedRectangle(cornerRadius: WadhahTheme.cornerRadius))
    }
}

/// Bottom navigation bar (visual prototype only).
struct WadhahTabBar: View {
    private let tabs: [(label: String, icon: String)] = [
        ("الرئيسية", "house.fill"),
        ("التحويل", "arrow.left.arrow.right"),
        ("المدفوعات", "creditcard"),
        ("المتجر", "bag"),
        ("الخدمات", "square.grid.2x2")
    ]

    var body: some View {
        HStack {
            ForEach(Array(tabs.enumerated()), id: \.offset) { index, tab in
                VStack(spacing: 4) {
                    Image(systemName: tab.icon)
                        .font(.system(size: 18))
                    Text(tab.label)
                        .font(.system(size: 10))
                }
                .foregroundStyle(index == 0 ? WadhahTheme.accent : WadhahTheme.textSecondary)
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 10)
        .background(WadhahTheme.card)
    }
}
