
# Wadhah (وضّح) — AI Banking Assistant

Wadhah is a generative AI assistant embedded directly inside the banking app. It improves the customer experience by providing instant, personalized support around the clock — turning confusing bank statements into clear, human answers.

## About

Wadhah relies on the customer's real account data to explain transactions and financial services in simple language. It interprets unfamiliar merchant names, clarifies why an amount was deducted, identifies recurring subscriptions, and explains fees and banking products.

It also links each transaction to the customer's history and categorizes merchants, helping users understand their spending and feel confident about it quickly. Beyond explanations, Wadhah lets customers take direct action — such as raising a dispute or canceling a subscription — which reduces pressure on call centers and raises customer satisfaction and trust in banking services.

## Key Features

- **Transaction clarification** — every transaction has a "وضح" (Clarify) button that opens a chat explaining the charge in plain language.
- **Merchant name interpretation** — decodes cryptic statement descriptors (e.g. `APPLE COM BILL`, `THAMAR AL-TANMIYA TRADING CO`) into the real merchant, location, and payment channel.
- **Subscription detection** — identifies recurring charges and renewal patterns.
- **Fee & product explanations** — answers questions about bank fees, cards, and products.
- **In-chat actions** — raise a dispute, escalate to customer care, view the merchant on a map, or cancel a subscription without leaving the conversation.
- **Context-aware answers** — responses are grounded in the customer's actual transaction history.

## App Screens

1. **Home Dashboard (الرئيسية)** — greeting header, loyalty points, current balance card, quick actions (bill payments, quick transfers, mobile top-up, traffic fines), promo banners, and the latest transactions.
2. **Transaction History (سجل العمليات)** — full list of operations, each with a Wadhah entry point.
3. **Wadhah Chat (وضّح - مساعدك البنكي)** — the assistant conversation with contextual action buttons per scenario.

## Tech Stack

| Layer | Technology |
|---|---|
| iOS UI | **SwiftUI** (iOS 17+, RTL-first Arabic interface) |
| Shared business logic | **Kotlin Multiplatform (KMP)** — transaction models, merchant enrichment, and assistant orchestration shared across platforms |
| Design | Custom dark navy theme with orange accent (`WadhahTheme`) |

SwiftUI drives the native iOS experience, while Kotlin Multiplatform hosts the platform-independent core (data models, business rules, and API layer), enabling a future Android client to reuse the same logic.

## Project Structure

```
WadhahApp/
├── WadhahApp.swift            # App entry point & navigation routes
├── AlinmaColors.swift         # Alinma brand palette (Color.alinma.*)
├── Theme.swift                # Corner radius + theme aliases over the palette
├── Models.swift               # Transaction, ChatScenario, dummy data
├── BankStore.swift            # Swift mirror of the KMP repository/assistant
├── Components.swift           # TransactionRow, WadhahPill, WadhahTabBar
├── DashboardView.swift        # Screen 1: Home dashboard (BankStore-driven)
├── HomeView.swift             # Deprecated alias (typealias HomeView = DashboardView)
├── TransactionHistoryView.swift # Screen 2: Transaction history
├── WadhahChatView.swift       # Screens 3 & 4: Wadhah chat (push or bottom sheet)
└── Assets.xcassets            # banklogo, Wad, car & airalo banners

shared/                        # Kotlin Multiplatform module
└── src/commonMain/kotlin/com/wadhah/shared/
    ├── model/                 # Account, BankTransaction, ChatMessage
    ├── data/MockBankRepository.kt   # Dummy balances & transactions
    └── chat/WadhahAssistant.kt      # Scripted assistant orchestration
```

### Building the KMP framework (macOS)

```
gradle wrapper                                        # once, to generate ./gradlew
./gradlew :shared:assembleWadhahSharedReleaseXCFramework
```

Then link `shared/build/XCFrameworks/release/WadhahShared.xcframework` into the
Xcode project and back `BankStore.swift` with the shared APIs (`MockBankRepository`,
`WadhahAssistant`) via a thin adapter — the KMP types carry the same data but not
identical shapes (e.g. `scenarioId: String?` maps to `ChatScenario`, and `systemIcon`
stays a Swift-side concern). The `:shared` module also has a `jvm()` target so the
Kotlin code builds and tests on any machine.

## Roadmap

- Wire the chat to a live generative AI backend through the KMP shared module.
- Android client reusing the shared Kotlin Multiplatform core.
- Real dispute and subscription-cancellation flows.
- Merchant location map integration.
