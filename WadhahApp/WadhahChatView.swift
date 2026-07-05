import SwiftUI

// MARK: - Screens 3 & 4: Wadhah Chat (وضح - مساعدك البنكي)
// Driven by WadhahChatEngine (the Swift mirror of the KMP WadhahAssistant).
// Presentable both pushed (from history) and as a bottom sheet (from the dashboard).

struct WadhahChatView: View {
    var asSheet = false
    @Environment(\.dismiss) private var dismiss
    @StateObject private var engine: WadhahChatEngine
    @State private var draft = ""

    init(scenario: ChatScenario?, asSheet: Bool = false) {
        self.asSheet = asSheet
        _engine = StateObject(wrappedValue: WadhahChatEngine(scenario: scenario))
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(engine.messages) { message in
                            bubble(for: message)
                                .id(message.id)
                        }

                        Text("وضح · الآن")
                            .font(.system(size: 10))
                            .foregroundStyle(WadhahTheme.textSecondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(16)
                }
                .onChange(of: engine.messages) { _, messages in
                    guard let last = messages.last else { return }
                    withAnimation(.easeOut(duration: 0.25)) {
                        proxy.scrollTo(last.id, anchor: .bottom)
                    }
                }
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

            if asSheet {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(WadhahTheme.textPrimary)
                            .frame(width: 32, height: 32)
                            .background(WadhahTheme.card, in: Circle())
                    }
                }
            }
        }
    }

    // MARK: Bubbles

    @ViewBuilder
    private func bubble(for message: WadhahChatMessage) -> some View {
        switch message.role {
        case .user:
            userBubble(message)
        case .assistant:
            assistantBubble(message)
        }
    }

    private func userBubble(_ message: WadhahChatMessage) -> some View {
        Text(message.text)
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(.white)
            .padding(14)
            .background(WadhahTheme.userBubble, in: RoundedRectangle(cornerRadius: 18))
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.leading, 40)
    }

    private func assistantBubble(_ message: WadhahChatMessage) -> some View {
        HStack(alignment: .bottom, spacing: 8) {
            wadAvatar

            VStack(alignment: .leading, spacing: 14) {
                if message.isTyping {
                    TypingIndicator()
                } else {
                    Text(message.text)
                        .font(.system(size: 14))
                        .foregroundStyle(Color.alinma.assistantInk)
                        .lineSpacing(3)
                }

                if message.actions.count >= 2 {
                    HStack(spacing: 10) {
                        ChatActionButton(title: message.actions[0], filled: true)
                        ChatActionButton(title: message.actions[1], filled: false)
                    }
                }
            }
            .padding(16)
            .background(WadhahTheme.assistantBubble, in: RoundedRectangle(cornerRadius: 18))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.trailing, 24)
    }

    /// Wadhah logo as the assistant's bubble avatar.
    private var wadAvatar: some View {
        Image("Wad")
            .resizable()
            .scaledToFit()
            .frame(width: 17, height: 17)
            .frame(width: 26, height: 26)
            .background(Color.alinma.copper, in: Circle())
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
                .onSubmit(send)

            Button(action: send) {
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

    private func send() {
        engine.send(draft)
        draft = ""
    }
}

// MARK: - Pieces

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

private struct TypingIndicator: View {
    @State private var animating = false

    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<3, id: \.self) { index in
                Circle()
                    .fill(Color(hex: 0xB7AB9E))
                    .frame(width: 7, height: 7)
                    .opacity(animating ? 1 : 0.25)
                    .animation(
                        .easeInOut(duration: 0.6)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.2),
                        value: animating
                    )
            }
        }
        .padding(.vertical, 4)
        .onAppear { animating = true }
    }
}
