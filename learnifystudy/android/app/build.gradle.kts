plugins {
    id("com.android.application")
    id("kotlin-android") // or "org.jetbrains.kotlin.android" depending on version
    id("dev.flutter.flutter-gradle-plugin")

    // --- FIREBASE PLUGIN ---
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.learnifystudy"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
    }

    defaultConfig {
        // Ensure this matches your Firebase Console package name
        applicationId = "com.example.learnifystudy"

        // As per SRS Requirement
        minSdk = flutter.minSdkVersion

        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // Signing config setup
            isMinifyEnabled = false
            isShrinkResources = false
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Basic dependencies
    implementation(platform("com.google.firebase:firebase-bom:32.7.0"))
}

configurations.all {
    resolutionStrategy {
        force("androidx.core:core-ktx:1.13.1")
        force("androidx.core:core:1.13.1")
    }
}