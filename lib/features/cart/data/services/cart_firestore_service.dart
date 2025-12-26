import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/cart_item_model.dart';

class CartFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _cartItems(String userId) =>
      _firestore.collection('users').doc(userId).collection('cart');

  // =====================================================
  // Cart Items - WRITE
  // ❗ CART IS STOCK-AGNOSTIC
  // =====================================================

  Future<void> addToCart(
    String userId,
    CartItemModel item,
  ) async {
    await _cartItems(userId).doc(item.id).set(item.toFirestore());
  }

  /// ---------------------------------------------------
  /// Update quantity ONLY
  /// ---------------------------------------------------
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

  /// ---------------------------------------------------
  /// Remove item
  /// ---------------------------------------------------
  Future<void> removeFromCart(
    String userId,
    String itemId,
  ) async {
    await _cartItems(userId).doc(itemId).delete();
  }

  /// ---------------------------------------------------
  /// Clear entire cart
  /// ---------------------------------------------------
  Future<void> clearCart(String userId) async {
    final batch = _firestore.batch();
    final snapshot = await _cartItems(userId).get();

    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  // =====================================================
  // Cart Items - READ
  // =====================================================

  Stream<List<CartItemModel>> getCartItemsStream(String userId) {
    return _cartItems(userId)
        .orderBy('addedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map(CartItemModel.fromFirestore).toList(),
        );
  }

  Future<List<CartItemModel>> getCartItems(String userId) async {
    final snapshot =
        await _cartItems(userId).orderBy('addedAt', descending: true).get();

    return snapshot.docs.map(CartItemModel.fromFirestore).toList();
  }

  Future<CartItemModel?> getCartItem(
    String userId,
    String itemId,
  ) async {
    final doc = await _cartItems(userId).doc(itemId).get();
    if (!doc.exists) return null;
    return CartItemModel.fromFirestore(doc);
  }

  Future<int> getCartItemCount(String userId) async {
    final snapshot = await _cartItems(userId).get();
    return snapshot.docs.length;
  }
}
