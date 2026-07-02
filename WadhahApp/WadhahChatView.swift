import SwiftUI

// MARK: - Screens 3 & 4: Wadhah Chat (وضح - مساعدك البنكي)
// One view drives both scripted scenarios (Apple subscription / ambiguous merchant).

struct WadhahChatView: View {
    let scenario: ChatScenario
    @State private var draft = ""

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 16) {
                    userBubble
                    assistantBubble
                    Text("وضح · الآن")
                        .font(.system(size: 10))
                        .foregroundStyle(WadhahTheme.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(16)
            }
            inputBar
        }
        .background(WadhahTheme.background)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(WadhahTheme.background, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbar {
            // principal = منتصف الشريط: العنوان وجنبه لوقو وضح بدائرة برتقالية بارزة
            ToolbarItem(placement: .principal) {
                HStack(spacing: 10) {
                    Text("وضّح - مساعدك البنكي")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.white)

                    Image("Wad")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 38, height: 38)
                        .clipShape(Circle())
                        .background(WadhahTheme.accent, in: Circle())
                }
            }
        }
    }

    // MARK: Bubbles

    private var userBubble: some View {
        Text(scenario.userMessage)
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(.white)
            .padding(14)
            .background(WadhahTheme.userBubble, in: RoundedRectangle(cornerRadius: 18))
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.leading, 40)
    }

    private var assistantBubble: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(scenario.assistantMessage)
                .font(.system(size: 14))
                .foregroundStyle(Color(hex: 0x2A2A2A))
                .lineSpacing(3)

            HStack(spacing: 10) {
                ChatActionButton(title: scenario.actions.primary, filled: true)
                ChatActionButton(title: scenario.actions.secondary, filled: false)
            }
        }
        .padding(16)
        .background(WadhahTheme.assistantBubble, in: RoundedRectangle(cornerRadius: 18))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.trailing, 32)
    }

    // MARK: Input bar

    private var inputBar: some View {
        HStack(spacing: 10) {
            TextField("اسأل عن عملية أو رسوم أو اشتراك...", text: $draft)
                .font(.system(size: 13))
                .foregroundStyle(WadhahTheme.textPrimary)
                .padding(.horizontal, 16)
                .frame(height: 46)
                .background(WadhahTheme.card, in: Capsule())

            Button {
                draft = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 15))
                    .foregroundStyle(.white)
                    // قلب أفقي عشان يأشر السهم لليسار مثل التصميم
                    .scaleEffect(x: -1, y: 1)
                    .frame(width: 46, height: 46)
                    .background(WadhahTheme.accent, in: Circle())
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(WadhahTheme.background)
    }
}

private struct ChatActionButton: View {
    let title: String
    let filled: Bool

    var body: some View {
        Button {} label: {
            Text(title)
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(filled ? .white : WadhahTheme.accent)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background {
                    if filled {
                        Capsule().fill(WadhahTheme.accent)
                    } else {
                        Capsule().stroke(WadhahTheme.accent, lineWidth: 1.5)
                    }
                }
        }
    }
}
