import SwiftUI

// MARK: - Screen 1: Home Dashboard (الرئيسية)
// Data comes from BankStore, the Swift mirror of the KMP MockBankRepository.
// Tapping a transaction opens the Wadhah chat as a bottom sheet.

struct DashboardView: View {
    @EnvironmentObject private var store: BankStore
    @State private var chatTransaction: Transaction?

    private let quickActions: [(label: String, icon: String)] = [
        ("دفع الفواتير", "doc.text"),
        ("الحوالات السريعة", "arrow.left.arrow.right.circle"),
        ("شحن الجوال", "iphone.gen3"),
        ("المخالفات المرورية", "car")
    ]

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 20) {
                    header
                    balanceCard
                    quickActionsRow
                    promoBanners
                    latestTransactions
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 24)
            }
            WadhahTabBar()
        }
        .background(WadhahTheme.background)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $chatTransaction) { transaction in
            NavigationStack {
                WadhahChatView(scenario: transaction.scenario, asSheet: true)
            }
            .environment(\.layoutDirection, .rightToLeft)
            .preferredColorScheme(.dark)
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }

    // MARK: Header (اللوقو + الترحيب + الجرس + النقاط)

    private var header: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 12) {
                Image("banklogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
                    .frame(width: 52, height: 52)
                    .background(.white, in: RoundedRectangle(cornerRadius: 16))

                VStack(alignment: .leading, spacing: 2) {
                    Text("مساء الخير")
                        .font(.system(size: 13))
                        .foregroundStyle(WadhahTheme.textSecondary)
                    Text("مرحبًا \(store.account.holderFirstName) 👋")
                        .font(.system(size: 19, weight: .bold))
                        .foregroundStyle(WadhahTheme.textPrimary)
                }

                Spacer()

                notificationBell
            }

            pointsBadge
        }
    }

    private var notificationBell: some View {
        ZStack(alignment: .topLeading) {
            Image(systemName: "bell")
                .font(.system(size: 17))
                .foregroundStyle(WadhahTheme.textPrimary)
                .frame(width: 44, height: 44)
                .background(WadhahTheme.card, in: Circle())

            Circle()
                .fill(WadhahTheme.accent)
                .frame(width: 9, height: 9)
                .offset(x: 6, y: 6)
        }
    }

    private var pointsBadge: some View {
        HStack(spacing: 6) {
            Image(systemName: "sparkle")
                .font(.system(size: 11, weight: .bold))
            Text("\(store.account.formattedPoints) نقطة")
                .font(.system(size: 13, weight: .bold))
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 14)
        .padding(.vertical, 7)
        .background(Color.alinma.pointsLavender.opacity(0.45), in: Capsule())
    }

    // MARK: Balance card (الرصيد الحالي)

    private var balanceCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("الرصيد الحالي")
                .font(.system(size: 14))
                .foregroundStyle(WadhahTheme.textSecondary)

            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text(store.account.formattedBalance)
                    .font(.system(size: 34, weight: .heavy))
                    .foregroundStyle(WadhahTheme.textPrimary)
                Text("SAR")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(WadhahTheme.textSecondary)
            }

            HStack {
                Text("•••• \(store.account.cardSuffix)")
                Spacer()
                Text("صالحة حتى \(store.account.cardExpiry)")
            }
            .font(.system(size: 12))
            .foregroundStyle(WadhahTheme.textSecondary)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(WadhahTheme.card, in: RoundedRectangle(cornerRadius: WadhahTheme.cornerRadius))
    }

    // MARK: Quick actions

    private var quickActionsRow: some View {
        HStack(spacing: 12) {
            ForEach(quickActions, id: \.label) { action in
                VStack(spacing: 8) {
                    Image(systemName: action.icon)
                        .font(.system(size: 20))
                        .foregroundStyle(WadhahTheme.accent)
                        .frame(width: 44, height: 44)
                        .background(WadhahTheme.background.opacity(0.6), in: Circle())
                    Text(action.label)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(WadhahTheme.textPrimary)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 96)
                .background(WadhahTheme.card, in: RoundedRectangle(cornerRadius: WadhahTheme.cornerRadius))
            }
        }
    }

    // MARK: Promo banners (صور من الـ Assets)

    private var promoBanners: some View {
        VStack(spacing: 12) {
            bannerImage("car")      // بنر الإنماء فانتزي
            bannerImage("airalo")   // بنر airalo / أكثر
        }
    }

    private func bannerImage(_ name: String) -> some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: WadhahTheme.cornerRadius))
    }

    // MARK: Latest transactions

    private var latestTransactions: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("آخر العمليات")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(WadhahTheme.textPrimary)
                Spacer()
                Text("آخر \(store.latestTransactions.count) عمليات")
                    .font(.system(size: 11))
                    .foregroundStyle(WadhahTheme.textSecondary)
            }

            ForEach(store.latestTransactions) { transaction in
                Button {
                    chatTransaction = transaction
                } label: {
                    TransactionRow(transaction: transaction)
                }
                .buttonStyle(.plain)
            }

            NavigationLink(value: Route.history) {
                Text("عرض الكل")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(WadhahTheme.accent, in: RoundedRectangle(cornerRadius: 14))
            }
        }
    }
}
