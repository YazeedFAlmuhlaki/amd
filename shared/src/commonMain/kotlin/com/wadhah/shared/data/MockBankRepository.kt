package com.wadhah.shared.data

import com.wadhah.shared.model.Account
import com.wadhah.shared.model.BankTransaction

/**
 * Dummy state for the hackathon prototype. The API shape is what a real
 * banking backend integration will implement later.
 */
object MockBankRepository {

    fun account(): Account = Account(
        holderFirstName = "أنس",
        balanceSAR = 18_240.75,
        cardSuffix = "4821",
        cardExpiry = "08/28",
        loyaltyPoints = 1_330,
    )

    fun recentTransactions(): List<BankTransaction> = listOf(
        BankTransaction(
            id = "tx-001",
            merchantDescriptor = "APPLE COM BILL",
            merchantDisplayName = "آبل",
            categoryLabel = "خدمات وتطبيقات إلكترونية",
            timestampLabel = "اليوم · 9:15 ص",
            amountSAR = -3.69,
            scenarioId = WadhahScenarioIds.APPLE_SUBSCRIPTION,
        ),
        BankTransaction(
            id = "tx-002",
            merchantDescriptor = "THAMAR AL-TANMIYA TRADING CO",
            merchantDisplayName = "ثمار التنمية",
            categoryLabel = "نقاط بيع - مدى",
            timestampLabel = "أمس · 8:30 م",
            amountSAR = -84.00,
            scenarioId = WadhahScenarioIds.AMBIGUOUS_MERCHANT,
        ),
        BankTransaction(
            id = "tx-003",
            merchantDescriptor = "HUNGERSTATION LLC",
            merchantDisplayName = "هنقرستيشن",
            categoryLabel = "توصيل طعام",
            timestampLabel = "قبل يومين",
            amountSAR = -50.84,
        ),
        BankTransaction(
            id = "tx-004",
            merchantDescriptor = "NAFT SERVICES CO",
            merchantDisplayName = "نفط",
            categoryLabel = "محطة وقود",
            timestampLabel = "قبل 3 أيام",
            amountSAR = -120.00,
        ),
        BankTransaction(
            id = "tx-005",
            merchantDescriptor = "ELIXIR BUN CO",
            merchantDisplayName = "إلكسير بن",
            categoryLabel = "قهوة مختصة",
            timestampLabel = "قبل 4 أيام",
            amountSAR = -26.00,
        ),
    )

    /** Home shows only the first [count]. */
    fun latestTransactions(count: Int = 3): List<BankTransaction> =
        recentTransactions().take(count)
}

object WadhahScenarioIds {
    const val APPLE_SUBSCRIPTION = "apple_subscription"
    const val AMBIGUOUS_MERCHANT = "ambiguous_merchant"
}
