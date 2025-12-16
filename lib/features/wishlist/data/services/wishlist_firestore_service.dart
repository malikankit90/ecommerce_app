import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/wishlist_item_model.dart';

class WishlistFirestoreService {
  final _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _wishlistItems(String userId) =>
      _firestore.collection('users').doc(userId).collection('wishlist');

  // =====================================================
  // Wishlist Items
  // =====================================================

  Future<void> addToWishlist(String userId, WishlistItemModel item) async {
    await _wishlistItems(userId).doc(item.id).set(item.toFirestore());
  }

  Future<void> removeFromWishlist(String userId, String itemId) async {
    await _wishlistItems(userId).doc(itemId).delete();
  }

  Future<void> clearWishlist(String userId) async {
    final batch = _firestore.batch();
    final snapshot = await _wishlistItems(userId).get();
    
    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    
    await batch.commit();
  }

  Stream<List<WishlistItemModel>> getWishlistItemsStream(String userId) {
    return _wishlistItems(userId)
        .orderBy('addedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => WishlistItemModel.fromFirestore(doc))
          .toList();
    });
  }

  Future<List<WishlistItemModel>> getWishlistItems(String userId) async {
    final snapshot = await _wishlistItems(userId)
        .orderBy('addedAt', descending: true)
        .get();
    
    return snapshot.docs
        .map((doc) => WishlistItemModel.fromFirestore(doc))
        .toList();
  }

  Future<bool> isInWishlist(String userId, String productId) async {
    final snapshot = await _wishlistItems(userId)
        .where('productId', isEqualTo: productId)
        .limit(1)
        .get();
    
    return snapshot.docs.isNotEmpty;
  }

  Future<int> getWishlistItemCount(String userId) async {
    final snapshot = await _wishlistItems(userId).get();
    return snapshot.docs.length;
  }
}