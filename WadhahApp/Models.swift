import Foundation

// MARK: - Domain Models (dummy data for the prototype)

struct Transaction: Identifiable, Hashable {
    let id = UUID()
    let merchant: String
    let category: String
    let timestamp: String
    let amountSAR: Double
    let systemIcon: String
    let scenario: ChatScenario?

    var formattedAmount: String {
        String(format: "%.2f SAR", amountSAR)
    }
}

/// The two scripted Wadhah conversations shown in the demo.
enum ChatScenario: Hashable {
    case appleSubscription
    case ambiguousMerchant

    var userMessage: String {
        switch self {
        case .appleSubscription:
            return "وشو تاجر (أبل كوم بيل) اللي خصم مني؟"
        case .ambiguousMerchant:
            return "مكتوب بالعملية (شركة ثمار التنمية للتجارة) ومخصوم 84 ريال، أنا ما رحت هالشركة!"
        }
    }

    var assistantMessage: String {
        switch self {
        case .appleSubscription:
            return "هذه عملية شراء أو تجديد اشتراك من شركة آبل، ومصنفة عندنا كخدمات وتطبيقات إلكترونية (مثل زيادة مساحة تخزين الهاتف أو اشتراك تطبيق). انخصم مبلغ 3.69 ريال اليوم الساعة 9:15 صباحاً.\nحاب تصعد الموضوع لخدمة العملاء أو تبغى ترفع اعتراض؟"
        case .ambiguousMerchant:
            return "تم التأكد من العملية؛ هذا الاسم التجاري مسجل لجهاز نقاط البيع الخاص بـ سوبرماركت أسواق النخبة (فرع حي الياسمين).\nتم دفع مبلغ 84 ريال عبر بطاقتك (مدى) بمسح الجهاز مباشرة، بتاريخ أمس الساعة 8:30 مساءً.\nحاب نفتح لك خريطة موقع المحل للتأكد؟"
        }
    }

    /// (primary filled, secondary outlined)
    var actions: (primary: String, secondary: String) {
        switch self {
        case .appleSubscription:
            return ("تصعيد لخدمة العملاء", "اعتراض على العملية")
        case .ambiguousMerchant:
            return ("موقع المحل على الخريطة", "تقديم اعتراض")
        }
    }
}

enum DummyData {
    static let recentTransactions: [Transaction] = [
        Transaction(
            merchant: "APPLE COM BILL",
            category: "خدمات وتطبيقات إلكترونية",
            timestamp: "اليوم · 9:15 ص",
            amountSAR: -3.69,
            systemIcon: "iphone",
            scenario: .appleSubscription
        ),
        Transaction(
            merchant: "THAMAR AL-TANMIYA TRADING CO",
            category: "نقاط بيع - مدى",
            timestamp: "أمس · 8:30 م",
            amountSAR: -84.00,
            systemIcon: "basket",
            scenario: .ambiguousMerchant
        ),
        Transaction(
            merchant: "HUNGERSTATION LLC",
            category: "توصيل طعام",
            timestamp: "قبل يومين",
            amountSAR: -50.84,
            systemIcon: "fork.knife",
            scenario: nil
        ),
        Transaction(
            merchant: "NAFT SERVICES CO",
            category: "محطة وقود",
            timestamp: "قبل 3 أيام",
            amountSAR: -120.00,
            systemIcon: "fuelpump",
            scenario: nil
        ),
        Transaction(
            merchant: "ELIXIR BUN CO",
            category: "قهوة مختصة",
            timestamp: "قبل 4 أيام",
            amountSAR: -26.00,
            systemIcon: "cup.and.saucer",
            scenario: nil
        )
    ]

    /// Home shows only the first 3.
    static var latestTransactions: [Transaction] {
        Array(recentTransactions.prefix(3))
    }
}
