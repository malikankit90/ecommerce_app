import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/cart_item_model.dart';

class CartFirestoreService {
  final _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _cartItems(String userId) =>
      _firestore.collection('users').doc(userId).collection('cart');

  // =====================================================
  // Cart Items
  // =====================================================

  Future<void> addToCart(String userId, CartItemModel item) async {
    await _cartItems(userId).doc(item.id).set(item.toFirestore());
  }

  Future<void> updateCartItem(
    String userId,
    String itemId,
    Map<String, dynamic> data,
  ) async {
    await _cartItems(userId).doc(itemId).update({
      ...data,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> removeFromCart(String userId, String itemId) async {
    await _cartItems(userId).doc(itemId).delete();
  }

  Future<void> clearCart(String userId) async {
    final batch = _firestore.batch();
    final snapshot = await _cartItems(userId).get();
    
    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    
    await batch.commit();
  }

  Stream<List<CartItemModel>> getCartItemsStream(String userId) {
    return _cartItems(userId)
        .orderBy('addedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => CartItemModel.fromFirestore(doc))
          .toList();
    });
  }

  Future<List<CartItemModel>> getCartItems(String userId) async {
    final snapshot = await _cartItems(userId)
        .orderBy('addedAt', descending: true)
        .get();
    
    return snapshot.docs
        .map((doc) => CartItemModel.fromFirestore(doc))
        .toList();
  }

  Future<CartItemModel?> getCartItem(String userId, String itemId) async {
    final doc = await _cartItems(userId).doc(itemId).get();
    if (!doc.exists) return null;
    return CartItemModel.fromFirestore(doc);
  }

  Future<int> getCartItemCount(String userId) async {
    final snapshot = await _cartItems(userId).get();
    return snapshot.docs.length;
  }

  Future<void> updateQuantity(
    String userId,
    String itemId,
    int quantity,
  ) async {
    await _cartItems(userId).doc(itemId).update({
      'quantity': quantity,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}