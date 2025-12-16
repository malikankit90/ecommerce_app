import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_app/features/auth/presentation/providers/auth_providers.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/repositories/cart_repository.dart';
import '../../data/services/cart_firestore_service.dart';

/// =======================================================
/// Service Providers
/// =======================================================

final cartFirestoreServiceProvider = Provider<CartFirestoreService>((ref) {
  return CartFirestoreService();
});

/// =======================================================
/// Repository Provider
/// =======================================================

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepository(
    firestoreService: ref.read(cartFirestoreServiceProvider),
  );
});

/// =======================================================
/// Cart Items Stream
/// =======================================================

final cartItemsStreamProvider =
    StreamProvider<List<CartItemModel>>((ref) async* {
  final authState = await ref.watch(authStateProvider.future);

  if (authState == null) {
    yield [];
    return;
  }

  yield* ref.read(cartRepositoryProvider).getCartItemsStream(authState.uid);
});

/// =======================================================
/// Cart Item Count
/// =======================================================

final cartItemCountProvider = Provider<int>((ref) {
  final cartItems = ref.watch(cartItemsStreamProvider);
  
  return cartItems.when(
    data: (items) => items.length,
    loading: () => 0,
    error: (_, __) => 0,
  );
});

/// =======================================================
/// Cart Totals
/// =======================================================

final cartTotalsProvider = Provider<Map<String, double>>((ref) {
  final cartItems = ref.watch(cartItemsStreamProvider);
  
  return cartItems.when(
    data: (items) {
      double subtotal = 0.0;
      double savings = 0.0;
      
      for (var item in items) {
        subtotal += item.subtotal;
        savings += item.savings;
      }
      
      return {
        'subtotal': subtotal,
        'savings': savings,
        'total': subtotal,
      };
    },
    loading: () => {
      'subtotal': 0.0,
      'savings': 0.0,
      'total': 0.0,
    },
    error: (_, __) => {
      'subtotal': 0.0,
      'savings': 0.0,
      'total': 0.0,
    },
  );
});

/// =======================================================
/// Cart Controller
/// =======================================================

final cartControllerProvider =
    StateNotifierProvider<CartController, AsyncValue<void>>((ref) {
  return CartController(
    cartRepository: ref.read(cartRepositoryProvider),
    ref: ref,
  );
});

class CartController extends StateNotifier<AsyncValue<void>> {
  final CartRepository _cartRepository;
  final Ref _ref;

  CartController({
    required CartRepository cartRepository,
    required Ref ref,
  })  : _cartRepository = cartRepository,
        _ref = ref,
        super(const AsyncValue.data(null));

  /// ---------------------------------------------------
  /// Get current user ID
  /// ---------------------------------------------------
  String? get _userId {
    final authState = _ref.read(authStateProvider).value;
    return authState?.uid;
  }

  /// ---------------------------------------------------
  /// Add to cart
  /// ---------------------------------------------------
  Future<void> addToCart(CartItemModel item) async {
    final userId = _userId;
    if (userId == null) {
      state = AsyncValue.error('User not authenticated', StackTrace.current);
      return;
    }

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _cartRepository.addToCart(userId, item);
    });
  }

  /// ---------------------------------------------------
  /// Update quantity
  /// ---------------------------------------------------
  Future<void> updateQuantity(String itemId, int quantity) async {
    final userId = _userId;
    if (userId == null) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _cartRepository.updateQuantity(userId, itemId, quantity);
    });
  }

  /// ---------------------------------------------------
  /// Remove from cart
  /// ---------------------------------------------------
  Future<void> removeFromCart(String itemId) async {
    final userId = _userId;
    if (userId == null) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _cartRepository.removeFromCart(userId, itemId);
    });
  }

  /// ---------------------------------------------------
  /// Clear cart
  /// ---------------------------------------------------
  Future<void> clearCart() async {
    final userId = _userId;
    if (userId == null) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _cartRepository.clearCart(userId);
    });
  }
}