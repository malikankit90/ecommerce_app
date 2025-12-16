# Build Configuration Guide

## Firebase Setup Checklist

### 1. Firebase Project Setup
- [ ] Create Firebase project at https://console.firebase.google.com/
- [ ] Enable Authentication (Email/Password + Google)
- [ ] Create Firestore Database
- [ ] Add Android app to Firebase
- [ ] Add iOS app to Firebase (if building for iOS)

### 2. Run FlutterFire Configure
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Login to Firebase
firebase login

# Configure your app
flutterfire configure
```

This command will:
- Generate `lib/firebase_options.dart`
- Download `android/app/google-services.json`
- Configure your Firebase project

### 3. Google Sign In Setup (Android)

#### Get SHA-1 Fingerprint
```bash
cd android
./gradlew signingReport
```

Look for the SHA-1 under `Task :app:signingReport` > `Variant: debug`

#### Add to Firebase Console
1. Go to Firebase Console > Project Settings
2. Select your Android app
3. Add the SHA-1 fingerprint
4. Download the updated `google-services.json`
5. Replace the file in `android/app/google-services.json`

### 4. Code Generation

After installing dependencies, run:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This generates:
- `*.freezed.dart` files (for immutable models)
- `*.g.dart` files (for JSON serialization)

### 5. Verify Setup

Run the app:
```bash
flutter run
```

Test these features:
- [ ] Email signup
- [ ] Email login
- [ ] Google Sign In
- [ ] Password reset
- [ ] Logout

## Firestore Indexes

You may need to create composite indexes for queries. Firebase will prompt you with a link when needed.

Common indexes needed:
- None for Phase 1 (basic queries only)

## Environment Variables (Optional)

For different environments (dev, staging, prod):

1. Create `lib/env/env.dart`:
```dart
class Env {
  static const String environment = String.fromEnvironment(
    'ENV',
    defaultValue: 'dev',
  );
  
  static const bool isProduction = environment == 'prod';
  static const bool isDevelopment = environment == 'dev';
}
```

2. Run with:
```bash
flutter run --dart-define=ENV=dev
flutter run --dart-define=ENV=prod
```

## Build Variants

### Debug Build
```bash
flutter build apk --debug
```

### Release Build
```bash
flutter build apk --release
```

### App Bundle (for Play Store)
```bash
flutter build appbundle --release
```

## Troubleshooting

### Issue: "Default FirebaseApp is not initialized"
**Solution**: Ensure `flutterfire configure` was run and `firebase_options.dart` exists

### Issue: "PlatformException(sign_in_failed)"
**Solution**: 
1. Verify SHA-1 is added to Firebase Console
2. Ensure `google-services.json` is in `android/app/`
3. Rebuild the app completely: `flutter clean && flutter pub get && flutter run`

### Issue: "FirebaseException: PERMISSION_DENIED"
**Solution**: Check Firestore Security Rules match the ones in README.md

### Issue: Code generation fails
**Solution**: 
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

## CI/CD Integration

### GitHub Actions Example

Create `.github/workflows/flutter.yml`:

```yaml
name: Flutter CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.22.0'
        channel: 'stable'
    
    - name: Install dependencies
      run: flutter pub get
    
    - name: Generate code
      run: flutter pub run build_runner build --delete-conflicting-outputs
    
    - name: Analyze
      run: flutter analyze
    
    - name: Run tests
      run: flutter test
    
    - name: Build APK
      run: flutter build apk --release
```

## Performance Optimization

### 1. Enable ProGuard (Already configured)
ProGuard rules are in `android/app/proguard-rules.pro`

### 2. Enable R8 Shrinking
Already enabled in `android/app/build.gradle.kts`:
```kotlin
buildTypes {
    release {
        isMinifyEnabled = true
        isShrinkResources = true
    }
}
```

### 3. Reduce APK Size
```bash
flutter build apk --release --split-per-abi
```

This creates separate APKs for:
- armeabi-v7a (32-bit ARM)
- arm64-v8a (64-bit ARM)
- x86_64 (64-bit x86)

## Monitoring & Analytics

### Firebase Analytics
Already integrated via `firebase-analytics-ktx`

Track custom events:
```dart
await FirebaseAnalytics.instance.logEvent(
  name: 'product_view',
  parameters: {
    'product_id': 'ABC123',
    'category': 'shirts',
  },
);
```

### Crashlytics (Add in Phase 2)
For crash reporting and monitoring

## Security Best Practices

1. ✅ Never commit `google-services.json` (in .gitignore)
2. ✅ Never commit API keys
3. ✅ Use Firestore Security Rules
4. ✅ Validate all user inputs
5. ✅ Use HTTPS only
6. ✅ Enable App Check (recommended for production)

## Production Checklist

Before releasing to production:

- [ ] Update app version in `pubspec.yaml`
- [ ] Update build number
- [ ] Test all authentication flows
- [ ] Test on multiple devices
- [ ] Enable ProGuard/R8
- [ ] Set up proper Firestore Security Rules
- [ ] Enable Firebase App Check
- [ ] Set up Firebase Analytics
- [ ] Set up Crashlytics
- [ ] Test offline functionality
- [ ] Optimize images and assets
- [ ] Remove debug prints and logs
- [ ] Update privacy policy
- [ ] Update terms and conditions
