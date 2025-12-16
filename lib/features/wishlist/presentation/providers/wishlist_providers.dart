import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_app/features/auth/presentation/providers/auth_providers.dart';
import '../../data/models/wishlist_item_model.dart';
import '../../data/repositories/wishlist_repository.dart';
import '../../data/services/wishlist_firestore_service.dart';

/// =======================================================
/// Service Providers
/// =======================================================

final wishlistFirestoreServiceProvider = Provider<WishlistFirestoreService>((ref) {
  return WishlistFirestoreService();
});

/// =======================================================
/// Repository Provider
/// =======================================================

final wishlistRepositoryProvider = Provider<WishlistRepository>((ref) {
  return WishlistRepository(
    firestoreService: ref.read(wishlistFirestoreServiceProvider),
  );
});

/// =======================================================
/// Wishlist Items Stream
/// =======================================================

final wishlistItemsStreamProvider =
    StreamProvider<List<WishlistItemModel>>((ref) async* {
  final authState = await ref.watch(authStateProvider.future);

  if (authState == null) {
    yield [];
    return;
  }

  yield* ref.read(wishlistRepositoryProvider).getWishlistItemsStream(authState.uid);
});

/// =======================================================
/// Wishlist Item Count
/// =======================================================

final wishlistItemCountProvider = Provider<int>((ref) {
  final wishlistItems = ref.watch(wishlistItemsStreamProvider);
  
  return wishlistItems.when(
    data: (items) => items.length,
    loading: () => 0,
    error: (_, __) => 0,
  );
});

/// =======================================================
/// Is Product in Wishlist
/// =======================================================

final isInWishlistProvider = Provider.family<bool, String>((ref, productId) {
  final wishlistItems = ref.watch(wishlistItemsStreamProvider);
  
  return wishlistItems.when(
    data: (items) => items.any((item) => item.productId == productId),
    loading: () => false,
    error: (_, __) => false,
  );
});

/// =======================================================
/// Wishlist Controller
/// =======================================================

final wishlistControllerProvider =
    StateNotifierProvider<WishlistController, AsyncValue<void>>((ref) {
  return WishlistController(
    wishlistRepository: ref.read(wishlistRepositoryProvider),
    ref: ref,
  );
});

class WishlistController extends StateNotifier<AsyncValue<void>> {
  final WishlistRepository _wishlistRepository;
  final Ref _ref;

  WishlistController({
    required WishlistRepository wishlistRepository,
    required Ref ref,
  })  : _wishlistRepository = wishlistRepository,
        _ref = ref,
        super(const AsyncValue.data(null));

  String? get _userId {
    final authState = _ref.read(authStateProvider).value;
    return authState?.uid;
  }

  /// ---------------------------------------------------
  /// Add to wishlist
  /// ---------------------------------------------------
  Future<void> addToWishlist(WishlistItemModel item) async {
    final userId = _userId;
    if (userId == null) {
      state = AsyncValue.error('User not authenticated', StackTrace.current);
      return;
    }

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _wishlistRepository.addToWishlist(userId, item);
    });
  }

  /// ---------------------------------------------------
  /// Remove from wishlist
  /// ---------------------------------------------------
  Future<void> removeFromWishlist(String itemId) async {
    final userId = _userId;
    if (userId == null) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _wishlistRepository.removeFromWishlist(userId, itemId);
    });
  }

  /// ---------------------------------------------------
  /// Toggle wishlist
  /// ---------------------------------------------------
  Future<void> toggleWishlist(
    String productId,
    WishlistItemModel item,
  ) async {
    final userId = _userId;
    if (userId == null) return;

    final isInWishlist = await _wishlistRepository.isInWishlist(userId, productId);

    if (isInWishlist) {
      // Find and remove
      final items = await _wishlistRepository.getWishlistItems(userId);
      final existingItem = items.firstWhere((i) => i.productId == productId);
      await removeFromWishlist(existingItem.id);
    } else {
      // Add
      await addToWishlist(item);
    }
  }

  /// ---------------------------------------------------
  /// Clear wishlist
  /// ---------------------------------------------------
  Future<void> clearWishlist() async {
    final userId = _userId;
    if (userId == null) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _wishlistRepository.clearWishlist(userId);
    });
  }
}