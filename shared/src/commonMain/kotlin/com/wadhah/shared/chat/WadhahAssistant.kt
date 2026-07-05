package com.wadhah.shared.chat

import com.wadhah.shared.data.WadhahScenarioIds
import com.wadhah.shared.model.ChatMessage
import com.wadhah.shared.model.ChatRole

/**
 * Scripted assistant orchestration for the demo. Holds the conversation state and
 * produces replies; a generative AI backend will implement this same surface later.
 * Mirrored by `WadhahChatEngine` in BankStore.swift until the XCFramework is wired in.
 */
class WadhahAssistant {

    private var nextId = 0
    private fun newId(): String = "msg-${nextId++}"

    /** The scripted opening exchange for a scenario, or a greeting when [scenarioId] is null/unknown. */
    fun openingThread(scenarioId: String?): List<ChatMessage> {
        val scenario = scenarios[scenarioId]
            ?: return listOf(
                ChatMessage(
                    id = newId(),
                    role = ChatRole.ASSISTANT,
                    text = "هلا! أنا وضّح 👋 اسألني عن أي عملية أو رسوم أو اشتراك في حسابك.",
                )
            )

        return listOf(
            ChatMessage(id = newId(), role = ChatRole.USER, text = scenario.userMessage),
            ChatMessage(
                id = newId(),
                role = ChatRole.ASSISTANT,
                text = scenario.assistantMessage,
                actions = scenario.actions,
            ),
        )
    }

    /** Canned free-text reply for the prototype. */
    fun reply(userText: String): ChatMessage = ChatMessage(
        id = newId(),
        role = ChatRole.ASSISTANT,
        text = "استلمت سؤالك 👌 هذي نسخة تجريبية من وضّح — في التطبيق الفعلي بجاوبك من بيانات حسابك وسجل عملياتك مباشرة.",
    )

    private data class Scenario(
        val userMessage: String,
        val assistantMessage: String,
        /** Primary (filled) first, secondary (outlined) second. */
        val actions: List<String>,
    )

    private val scenarios: Map<String, Scenario> = mapOf(
        WadhahScenarioIds.APPLE_SUBSCRIPTION to Scenario(
            userMessage = "وشو تاجر (أبل كوم بيل) اللي خصم مني؟",
            assistantMessage = "هذه عملية شراء أو تجديد اشتراك من شركة آبل، ومصنفة عندنا كخدمات وتطبيقات إلكترونية (مثل زيادة مساحة تخزين الهاتف أو اشتراك تطبيق). انخصم مبلغ 3.69 ريال اليوم الساعة 9:15 صباحاً.\nحاب تصعد الموضوع لخدمة العملاء أو تبغى ترفع اعتراض؟",
            actions = listOf("تصعيد لخدمة العملاء", "اعتراض على العملية"),
        ),
        WadhahScenarioIds.AMBIGUOUS_MERCHANT to Scenario(
            userMessage = "مكتوب بالعملية (شركة ثمار التنمية للتجارة) ومخصوم 84 ريال، أنا ما رحت هالشركة!",
            assistantMessage = "تم التأكد من العملية؛ هذا الاسم التجاري مسجل لجهاز نقاط البيع الخاص بـ سوبرماركت أسواق النخبة (فرع حي الياسمين).\nتم دفع مبلغ 84 ريال عبر بطاقتك (مدى) بمسح الجهاز مباشرة، بتاريخ أمس الساعة 8:30 مساءً.\nحاب نفتح لك خريطة موقع المحل للتأكد؟",
            actions = listOf("موقع المحل على الخريطة", "تقديم اعتراض"),
        ),
    )
}
