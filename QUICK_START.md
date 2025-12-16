# Quick Start Guide - E-Commerce App Phase 1

## 🚀 Get Started in 5 Minutes

### Step 1: Install Dependencies
```bash
cd ecommerce_app
flutter pub get
```

### Step 2: Configure Firebase
```bash
# Install FlutterFire CLI (one time only)
dart pub global activate flutterfire_cli

# Login to Firebase
firebase login

# Configure your project
flutterfire configure
```

Select your Firebase project or create a new one. This will generate `firebase_options.dart`.

### Step 3: Enable Firebase Services

Go to [Firebase Console](https://console.firebase.google.com/):

1. **Authentication**
   - Click "Authentication" → "Get Started"
   - Enable "Email/Password"
   - Enable "Google"

2. **Firestore Database**
   - Click "Firestore Database" → "Create Database"
   - Choose "Start in production mode"
   - Select a location

3. **Add Firestore Rules**
   - Go to "Firestore Database" → "Rules"
   - Paste the rules from `README.md` (Firestore Security Rules section)
   - Publish the rules

### Step 4: Android Setup (for Google Sign In)

```bash
# Get SHA-1 fingerprint
cd android
./gradlew signingReport
```

Copy the SHA-1 fingerprint, then:
1. Go to Firebase Console → Project Settings
2. Select your Android app
3. Click "Add fingerprint"
4. Paste the SHA-1
5. Download `google-services.json`
6. Place it in `android/app/google-services.json`

### Step 5: Generate Code
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 6: Run the App
```bash
flutter run
```

## ✅ Test Authentication

1. **Sign Up**
   - Open the app
   - Click "Sign Up"
   - Enter your details
   - Create account

2. **Email Verification**
   - Check your email
   - Click the verification link

3. **Sign In**
   - Sign in with your email and password
   - Or use "Continue with Google"

4. **Home Page**
   - See your name in the welcome section
   - Explore categories
   - Test logout from the menu

## 🎯 What's Included in Phase 1

✅ **Authentication**
- Email/Password signup & login
- Google Sign In
- Password reset
- Email verification
- Auto logout/login based on auth state

✅ **Home Page**
- User welcome section
- Category cards
- Navigation menu
- Logout functionality

✅ **Modern Architecture**
- Riverpod 2.x state management
- Clean architecture
- Freezed models
- GoRouter navigation
- Firebase integration

## 📁 Project Structure

```
lib/
├── core/
│   ├── router/          # Navigation with GoRouter
│   └── widgets/         # Reusable widgets
├── features/
│   ├── auth/           # Authentication feature
│   │   ├── data/       # Models, services, repositories
│   │   └── presentation/  # Screens and providers
│   └── home/           # Home feature
└── main.dart           # App entry point
```

## 🔄 Next Steps

After Phase 1 is working:

**Phase 2** will include:
- Products listing
- Product details
- Categories
- Search functionality
- Filters

**Phase 3** will add:
- Shopping cart
- Checkout flow
- Order management

## 🐛 Troubleshooting

**App crashes on startup?**
- Run: `flutter clean && flutter pub get && flutter run`
- Verify `firebase_options.dart` exists

**Google Sign In not working?**
- Check SHA-1 is added to Firebase Console
- Verify `google-services.json` is in `android/app/`
- Rebuild: `flutter clean && flutter run`

**Code generation fails?**
- Run: `flutter pub run build_runner clean`
- Then: `flutter pub run build_runner build --delete-conflicting-outputs`

**Firestore permission denied?**
- Check Security Rules in Firebase Console
- Make sure they match the rules in README.md

## 📞 Need Help?

Check these files for detailed information:
- `README.md` - Complete documentation
- `BUILD_GUIDE.md` - Detailed build instructions
- Firebase Console logs for runtime errors

## 🎉 You're Ready!

Your Phase 1 e-commerce app is now running with:
- ✅ Modern Flutter 3.22+
- ✅ Riverpod 2.x
- ✅ Firebase Auth
- ✅ Firestore
- ✅ Clean architecture
- ✅ Type-safe code

Start developing Phase 2 features! 🚀
