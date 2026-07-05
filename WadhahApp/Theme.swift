import SwiftUI

// MARK: - Design System
// Colors delegate to the Alinma brand palette (AlinmaColors.swift).

enum WadhahTheme {
    // Colors
    static let background = Color.alinma.background
    static let card = Color.alinma.card
    static let cardElevated = Color.alinma.cardElevated
    static let accent = Color.alinma.accent
    static let textPrimary = Color.alinma.textPrimary
    static let textSecondary = Color.alinma.textSecondary
    static let userBubble = Color.alinma.userBubble
    static let assistantBubble = Color.alinma.assistantBubble

    // Metrics
    static let cornerRadius: CGFloat = 16
    static let pillRadius: CGFloat = 100
}
