package com.wadhah.shared.model

/**
 * A card/account transaction plus Wadhah's merchant enrichment.
 * Mirrored by `Transaction` in Models.swift until the XCFramework is wired in.
 */
data class BankTransaction(
    val id: String,
    /** Raw statement descriptor, e.g. "APPLE COM BILL". */
    val merchantDescriptor: String,
    /** Enriched, human-readable merchant name, e.g. "آبل". */
    val merchantDisplayName: String,
    /** Arabic category label, e.g. "خدمات وتطبيقات إلكترونية". */
    val categoryLabel: String,
    /** Display timestamp as shown in the demo, e.g. "اليوم · 9:15 ص". */
    val timestampLabel: String,
    /** Negative for debits. */
    val amountSAR: Double,
    /** Links the transaction to a scripted assistant scenario, when one exists. */
    val scenarioId: String? = null,
)
