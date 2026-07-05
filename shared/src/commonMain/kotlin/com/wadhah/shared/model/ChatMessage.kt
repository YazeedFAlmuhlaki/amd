package com.wadhah.shared.model

enum class ChatRole { USER, ASSISTANT }

/**
 * One message in a Wadhah conversation.
 * Mirrored by `WadhahChatMessage` in BankStore.swift until the XCFramework is wired in.
 */
data class ChatMessage(
    val id: String,
    val role: ChatRole,
    val text: String,
    /** Contextual action buttons rendered inside the assistant bubble (primary first). */
    val actions: List<String> = emptyList(),
)
