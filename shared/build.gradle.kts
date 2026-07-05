import org.jetbrains.kotlin.gradle.plugin.mpp.apple.XCFramework

plugins {
    kotlin("multiplatform")
}

kotlin {
    // JVM target keeps the shared logic buildable/testable on any machine.
    jvm()

    // iOS: packaged as WadhahShared.xcframework for the SwiftUI app.
    // Build on macOS with: gradle :shared:assembleWadhahSharedReleaseXCFramework
    val xcf = XCFramework("WadhahShared")
    listOf(
        iosArm64(),
        iosSimulatorArm64(),
        iosX64()
    ).forEach { iosTarget ->
        iosTarget.binaries.framework {
            baseName = "WadhahShared"
            isStatic = true
            xcf.add(this)
        }
    }

    sourceSets {
        commonMain.dependencies {
            // Pure Kotlin — no external dependencies needed for the mock layer.
        }
        commonTest.dependencies {
            implementation(kotlin("test"))
        }
    }
}
