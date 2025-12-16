# E-Commerce Clothing App - Phase 1

Modern Flutter e-commerce application with Firebase Authentication and Riverpod state management.

## ✅ Phase 1 Features

- 🔐 **Authentication**
  - Email/Password signup & login
  - Google Sign In
  - Password reset
  - Email verification
  - Protected routes
  
- 🏠 **Home Page**
  - Welcome section with user info
  - Categories preview
  - Featured products section (placeholder for Phase 2)
  - User menu with logout

## 🛠 Tech Stack

- **Flutter**: >= 3.22.0
- **Dart**: >= 3.3.0
- **State Management**: Riverpod 2.5.1
- **Firebase**: 
  - Authentication
  - Firestore
  - Cloud Messaging
- **Navigation**: GoRouter 14.6.2
- **Architecture**: Clean Architecture + Feature-First

## 📁 Project Structure

```
lib/
├── core/
│   ├── router/
│   │   └── app_router.dart
│   └── widgets/
│       ├── custom_button.dart
│       └── custom_text_field.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── user_model.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── services/
│   │   │       ├── auth_service.dart
│   │   │       └── firestore_service.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── auth_providers.dart
│   │       └── screens/
│   │           ├── login_screen.dart
│   │           └── signup_screen.dart
│   └── home/
│       └── presentation/
│           └── screens/
│               └── home_screen.dart
├── firebase_options.dart
└── main.dart
```

## 🚀 Setup Instructions

### Prerequisites

1. Flutter SDK >= 3.22.0
2. Dart SDK >= 3.3.0
3. Firebase CLI
4. FlutterFire CLI

### Install FlutterFire CLI

```bash
dart pub global activate flutterfire_cli
```

### Firebase Setup

1. **Create a Firebase Project**
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Create a new project
   - Enable Google Analytics (optional)

2. **Enable Authentication**
   - In Firebase Console, go to Authentication
   - Enable Email/Password sign-in method
   - Enable Google sign-in method

3. **Create Firestore Database**
   - In Firebase Console, go to Firestore Database
   - Create database in production mode
   - Choose a location

4. **Configure Firebase for Flutter**

```bash
# Login to Firebase
firebase login

# Configure FlutterFire
flutterfire configure
```

This will:
- Create `firebase_options.dart` with your Firebase config
- Register your app with Firebase
- Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)

5. **For Google Sign In (Android)**
   - In Firebase Console, download `google-services.json`
   - Place it in `android/app/`
   - Get SHA-1 fingerprint:
     ```bash
     cd android
     ./gradlew signingReport
     ```
   - Add SHA-1 to Firebase Console (Project Settings > Your App)

### Install Dependencies

```bash
flutter pub get
```

### Generate Code

```bash
# Generate Freezed and JSON serialization code
flutter pub run build_runner build --delete-conflicting-outputs
```

### Run the App

```bash
flutter run
```

## 🔒 Firestore Security Rules

Add these rules to your Firestore:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Users collection
    match /users/{userId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null && request.auth.uid == userId;
      allow update: if request.auth != null && request.auth.uid == userId;
      allow delete: if request.auth != null && request.auth.uid == userId;
      
      // User addresses sub-collection
      match /addresses/{addressId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
      
      // User payment methods sub-collection
      match /payment_methods/{paymentId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
  }
}
```

## 🎨 Customization

### Change App Name

1. Update `pubspec.yaml`:
```yaml
name: your_app_name
```

2. Update Android app name in `android/app/src/main/AndroidManifest.xml`:
```xml
<application android:label="Your App Name">
```

### Change Package Name

1. Update `android/app/build.gradle.kts`:
```kotlin
namespace = "com.yourcompany.yourapp"
```

2. Update `MainActivity.kt` package name

3. Update folder structure in `android/app/src/main/kotlin/`

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

## 📱 Build Release

### Android

```bash
flutter build apk --release
# or for App Bundle
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

## 🔄 Next Phases

- **Phase 2**: Products, Categories, Search
- **Phase 3**: Cart, Checkout, Orders
- **Phase 4**: User Profile, Addresses, Payment Methods
- **Phase 5**: Reviews, Wishlist, Notifications

## 📝 Notes

- All code follows STRICT rules (Kotlin DSL, Riverpod 2.x, Flutter 3.22+)
- No deprecated APIs or legacy code
- Production-ready architecture
- Type-safe with Freezed models
- Protected routes with GoRouter
- Firebase BOM for version management

## 🐛 Common Issues

### Build Errors

1. **Multidex error**: Already enabled in `build.gradle.kts`
2. **Firebase version conflicts**: Using Firebase BOM
3. **Freezed generation issues**: Run `flutter pub run build_runner build --delete-conflicting-outputs`

### Runtime Errors

1. **Firebase not initialized**: Check `firebase_options.dart`
2. **Google Sign In fails**: Verify SHA-1 in Firebase Console
3. **Firestore permission denied**: Check security rules

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Riverpod Documentation](https://riverpod.dev/)
- [GoRouter Documentation](https://pub.dev/packages/go_router)

## 📄 License

This project is licensed under the MIT License.
