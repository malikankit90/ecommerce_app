import '../models/wishlist_item_model.dart';
import '../services/wishlist_firestore_service.dart';

class WishlistRepository {
  final WishlistFirestoreService _firestoreService;

  WishlistRepository({
    required WishlistFirestoreService firestoreService,
  }) : _firestoreService = firestoreService;

  // =====================================================
  // Wishlist Items - Read
  // =====================================================

  Stream<List<WishlistItemModel>> getWishlistItemsStream(String userId) {
    try {
      return _firestoreService.getWishlistItemsStream(userId);
    } catch (e) {
      throw Exception('Failed to stream wishlist items: $e');
    }
  }

  Future<List<WishlistItemModel>> getWishlistItems(String userId) async {
    try {
      return await _firestoreService.getWishlistItems(userId);
    } catch (e) {
      throw Exception('Failed to get wishlist items: $e');
    }
  }

  Future<bool> isInWishlist(String userId, String productId) async {
    try {
      return await _firestoreService.isInWishlist(userId, productId);
    } catch (e) {
      throw Exception('Failed to check wishlist: $e');
    }
  }

  Future<int> getWishlistItemCount(String userId) async {
    try {
      return await _firestoreService.getWishlistItemCount(userId);
    } catch (e) {
      throw Exception('Failed to get wishlist count: $e');
    }
  }

  // =====================================================
  // Wishlist Items - Write
  // =====================================================

  Future<void> addToWishlist(String userId, WishlistItemModel item) async {
    try {
      await _firestoreService.addToWishlist(userId, item);
    } catch (e) {
      throw Exception('Failed to add to wishlist: $e');
    }
  }

  Future<void> removeFromWishlist(String userId, String itemId) async {
    try {
      await _firestoreService.removeFromWishlist(userId, itemId);
    } catch (e) {
      throw Exception('Failed to remove from wishlist: $e');
    }
  }

  Future<void> clearWishlist(String userId) async {
    try {
      await _firestoreService.clearWishlist(userId);
    } catch (e) {
      throw Exception('Failed to clear wishlist: $e');
    }
  }
}