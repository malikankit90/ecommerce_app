import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class AuthRepository {
  final AuthService _authService;
  final FirestoreService _firestoreService;

  AuthRepository({
    required AuthService authService,
    required FirestoreService firestoreService,
  })  : _authService = authService,
        _firestoreService = firestoreService;

  // =====================================================
  // Auth state
  // =====================================================
  User? get currentUser => _authService.currentUser;
  Stream<User?> get authStateChanges => _authService.authStateChanges;

  Stream<UserModel?> getCurrentUserDataStream() {
    final uid = currentUser?.uid;
    if (uid == null) return const Stream.empty();
    return _firestoreService.getUserStream(uid);
  }

  // =====================================================
  // Sign up (Email)
  // =====================================================
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final credential = await _authService.signUpWithEmail(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw Exception('Firebase user is null');
    }

    final userModel = UserModel.fromFirebaseUser(
      uid: user.uid,
      email: email,
      firstName: firstName,
      lastName: lastName,
    );

    await _firestoreService.createUser(userModel);
    await _authService.updateProfile(displayName: userModel.fullName);

    return userModel;
  }

  // =====================================================
  // Sign in (Email)
  // =====================================================
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final credential = await _authService.signInWithEmail(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw Exception('Firebase user is null');
    }

    await _firestoreService.updateLastLogin(user.uid);

    final userModel = await _firestoreService.getUserById(user.uid);
    if (userModel == null) {
      throw Exception('User document not found');
    }

    return userModel;
  }

  // =====================================================
  // Sign in (Google)
  // =====================================================
  Future<UserModel> signInWithGoogle() async {
    final credential = await _authService.signInWithGoogle();
    final user = credential.user;

    if (user == null) {
      throw Exception('Google sign-in failed');
    }

    UserModel? userModel =
        await _firestoreService.getUserById(user.uid);

    if (userModel == null) {
      final nameParts =
          (user.displayName ?? 'User').trim().split(' ');

      userModel = UserModel.fromFirebaseUser(
        uid: user.uid,
        email: user.email ?? '',
        firstName: nameParts.first,
        lastName:
            nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
      ).copyWith(
        profileImageUrl: user.photoURL,
        emailVerified: user.emailVerified,
      );

      await _firestoreService.createUser(userModel);
    } else {
      await _firestoreService.updateLastLogin(user.uid);
    }

    return userModel;
  }

  // =====================================================
  // Misc / Account
  // =====================================================
  Future<void> signOut() => _authService.signOut();

  Future<void> sendPasswordResetEmail(String email) =>
      _authService.sendPasswordResetEmail(email);

  Future<void> sendEmailVerification() =>
      _authService.sendEmailVerification();

  Future<void> reloadUser() => _authService.reloadUser();

  Future<void> updateUserData(
    String userId,
    Map<String, dynamic> data,
  ) =>
      _firestoreService.updateUser(userId, data);

  Future<UserModel?> getUserById(String userId) =>
      _firestoreService.getUserById(userId);

  Future<void> updateFcmToken(String? token) async {
    final uid = currentUser?.uid;
    if (uid != null) {
      await _firestoreService.updateFcmToken(uid, token);
    }
  }
}
