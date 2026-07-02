import SwiftUI

// MARK: - Design System

enum WadhahTheme {
    // Colors
    static let background = Color(hex: 0x0B1F32)      // Deep navy
    static let card = Color(hex: 0x122B40)            // Container navy
    static let cardElevated = Color(hex: 0x1A3B50)
    static let accent = Color(hex: 0xE65C00)          // Alinma orange/copper
    static let textPrimary = Color.white
    static let textSecondary = Color.white.opacity(0.55)
    static let userBubble = Color(hex: 0x1E63D0)      // Chat user blue
    static let assistantBubble = Color(hex: 0xF4EDE6) // Chat reply off-white

    // Metrics
    static let cornerRadius: CGFloat = 16
    static let pillRadius: CGFloat = 100
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}
