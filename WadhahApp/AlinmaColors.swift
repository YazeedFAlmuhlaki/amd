import SwiftUI

// MARK: - Alinma Brand Palette
// Hex values pixel-sampled from the official brand assets (banklogo) and app screens.

struct AlinmaPalette {
    let primary = Color(hex: 0x0C2342)          // Brand navy (logo background)
    let background = Color(hex: 0x0B1F32)       // Screen background
    let card = Color(hex: 0x122B40)             // Cards / containers
    let cardElevated = Color(hex: 0x1A3B50)     // Icon tiles inside cards
    let accent = Color(hex: 0xE65C00)           // Alinma orange (CTAs, active tab)
    let copper = Color(hex: 0xD17D58)           // Wadhah pill / avatar circle
    let userBubble = Color(hex: 0x1E63D0)       // Chat: user message blue
    let assistantBubble = Color(hex: 0xF4EDE6)  // Chat: assistant reply off-white
    let assistantInk = Color(hex: 0x2A2A2A)     // Chat: assistant text on off-white
    let pointsLavender = Color(hex: 0x8B7BC7)   // Loyalty points badge
    let textPrimary = Color.white
    let textSecondary = Color.white.opacity(0.55)
}

extension Color {
    /// Usage: `Color.alinma.accent`, `Color.alinma.card`, …
    static let alinma = AlinmaPalette()

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
