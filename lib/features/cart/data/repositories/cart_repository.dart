import '../models/cart_item_model.dart';
import '../services/cart_firestore_service.dart';

class CartRepository {
  final CartFirestoreService _firestoreService;

  CartRepository({
    required CartFirestoreService firestoreService,
  }) : _firestoreService = firestoreService;

  // =====================================================
  // Cart Items - READ
  // =====================================================

  Stream<List<CartItemModel>> getCartItemsStream(String userId) {
    try {
      return _firestoreService.getCartItemsStream(userId);
    } catch (e) {
      throw Exception('Failed to stream cart items: $e');
    }
  }

  Future<List<CartItemModel>> getCartItems(String userId) async {
    try {
      return await _firestoreService.getCartItems(userId);
    } catch (e) {
      throw Exception('Failed to get cart items: $e');
    }
  }

  Future<CartItemModel?> getCartItem(
    String userId,
    String itemId,
  ) async {
    try {
      return await _firestoreService.getCartItem(userId, itemId);
    } catch (e) {
      throw Exception('Failed to get cart item: $e');
    }
  }

  Future<int> getCartItemCount(String userId) async {
    try {
      return await _firestoreService.getCartItemCount(userId);
    } catch (e) {
      throw Exception('Failed to get cart count: $e');
    }
  }

  // =====================================================
  // Cart Items - WRITE
  // ❗ CART IS STOCK-AGNOSTIC
  // =====================================================

  Future<void> addToCart(
    String userId,
    CartItemModel item,
  ) async {
    try {
      await _firestoreService.addToCart(userId, item);
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  /// ---------------------------------------------------
  /// Update quantity ONLY
  /// ❌ No stock checks
  /// ❌ No availability validation
  /// ---------------------------------------------------
  Future<void> updateQuantity(
    String userId,
    String itemId,
    int quantity,
  ) async {
    try {
      if (quantity <= 0) {
        await _firestoreService.removeFromCart(userId, itemId);
        return;
      }

      await _firestoreService.updateQuantity(
        userId,
        itemId,
        quantity,
      );
    } catch (e) {
      throw Exception('Failed to update quantity: $e');
    }
  }

  /// ---------------------------------------------------
  /// Remove item
  /// ---------------------------------------------------
  Future<void> removeFromCart(
    String userId,
    String itemId,
  ) async {
    try {
      await _firestoreService.removeFromCart(userId, itemId);
    } catch (e) {
      throw Exception('Failed to remove from cart: $e');
    }
  }

  /// ---------------------------------------------------
  /// Clear entire cart
  /// ---------------------------------------------------
  Future<void> clearCart(String userId) async {
    try {
      await _firestoreService.clearCart(userId);
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }
}
