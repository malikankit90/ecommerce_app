import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Feature imports
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/firestore_service.dart';

/// =======================================================
/// Service Providers (low-level)
/// =======================================================

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});

/// =======================================================
/// Repository Provider
/// =======================================================

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    authService: ref.read(authServiceProvider),
    firestoreService: ref.read(firestoreServiceProvider),
  );
});

/// =======================================================
/// Firebase Auth State
/// =======================================================
/// Emits immediately:
/// - null (initial)
/// - then User once Firebase restores session
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authRepositoryProvider).authStateChanges;
});

/// =======================================================
/// Firestore User Document
/// =======================================================
/// IMPORTANT:
/// - waits for authStateProvider
/// - avoids permission-denied on first frame
final currentUserDataProvider = StreamProvider<UserModel?>((ref) async* {
  final authState = await ref.watch(authStateProvider.future);

  if (authState == null) {
    yield null;
    return;
  }

  yield* ref
      .read(authRepositoryProvider)
      .getCurrentUserDataStream();
});

/// =======================================================
/// Auth Controller
/// =======================================================

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
  return AuthController(
    authRepository: ref.read(authRepositoryProvider),
  );
});

class AuthController extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _authRepository;

  AuthController({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AsyncValue.data(null));

  /// ---------------------------------------------------
  /// Sign up
  /// ---------------------------------------------------
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authRepository.signUpWithEmail(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
    });
  }

  /// ---------------------------------------------------
  /// Sign in (email)
  /// ---------------------------------------------------
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authRepository.signInWithEmail(
        email: email,
        password: password,
      );
    });
  }

  /// ---------------------------------------------------
  /// Google sign-in
  /// ---------------------------------------------------
  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authRepository.signInWithGoogle();
    });
  }

  /// ---------------------------------------------------
  /// Sign out
  /// ---------------------------------------------------
  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authRepository.signOut();
    });
  }

  /// ---------------------------------------------------
  /// Password reset
  /// ---------------------------------------------------
  Future<void> sendPasswordResetEmail(String email) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authRepository.sendPasswordResetEmail(email);
    });
  }

  /// ---------------------------------------------------
  /// Email verification
  /// ---------------------------------------------------
  Future<void> sendEmailVerification() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authRepository.sendEmailVerification();
    });
  }
}
