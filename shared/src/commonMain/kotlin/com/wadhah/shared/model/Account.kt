package com.wadhah.shared.model

/**
 * Customer account snapshot shown on the dashboard.
 * Mirrored by `Account` in BankStore.swift until the XCFramework is wired in.
 */
data class Account(
    val holderFirstName: String,
    val balanceSAR: Double,
    val cardSuffix: String,
    val cardExpiry: String,
    val loyaltyPoints: Int,
    val currency: String = "SAR",
)
