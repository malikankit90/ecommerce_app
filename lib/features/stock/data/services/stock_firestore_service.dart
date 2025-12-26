import 'package:cloud_firestore/cloud_firestore.dart';

class StockFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _products =>
      _firestore.collection('products');

  CollectionReference<Map<String, dynamic>> get _reservations =>
      _firestore.collection('stock_reservations');

  /// ---------------------------------------------------
  /// RESERVE STOCK (ATOMIC + GUARDED)
  /// ---------------------------------------------------
  Future<String?> reserveStock({
    required String productId,
    required int quantity,
    required String orderId,
    Duration ttl = const Duration(minutes: 15),
  }) async {
    final reservationRef = _reservations.doc();

    return _firestore.runTransaction<String?>((tx) async {
      final productRef = _products.doc(productId);
      final productSnap = await tx.get(productRef);

      if (!productSnap.exists) return null;

      final data = productSnap.data()!;
      final int totalStock = (data['totalStock'] ?? 0) as int;
      final int reservedStock = (data['reservedStock'] ?? 0) as int;

      final int available = totalStock - reservedStock;
      if (available < quantity || quantity <= 0) return null;

      // 🔒 Reserve
      tx.update(productRef, {
        'reservedStock': reservedStock + quantity,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      tx.set(reservationRef, {
        'productId': productId,
        'quantity': quantity,
        'orderId': orderId,
        'status': 'active',
        'expiresAt': Timestamp.fromDate(
          DateTime.now().add(ttl),
        ),
        'createdAt': FieldValue.serverTimestamp(),
      });

      return reservationRef.id;
    });
  }

  /// ---------------------------------------------------
  /// COMMIT RESERVATION (PAYMENT SUCCESS / COD)
  /// ---------------------------------------------------
  Future<void> commitReservation(String reservationId) async {
    await _firestore.runTransaction((tx) async {
      final resRef = _reservations.doc(reservationId);
      final resSnap = await tx.get(resRef);

      if (!resSnap.exists) return;

      final data = resSnap.data()!;
      if (data['status'] != 'active') return;

      final expiresAt = (data['expiresAt'] as Timestamp).toDate();
      if (expiresAt.isBefore(DateTime.now())) {
        // ❌ Expired → release instead
        await _releaseInternal(tx, resRef, data);
        return;
      }

      final String productId = data['productId'];
      final int quantity = data['quantity'];

      final productRef = _products.doc(productId);
      final productSnap = await tx.get(productRef);
      if (!productSnap.exists) return;

      final product = productSnap.data()!;
      final int totalStock = product['totalStock'];
      final int reservedStock = product['reservedStock'];

      if (reservedStock < quantity || totalStock < quantity) {
        // Data corruption guard
        throw Exception('Invalid stock state during commit');
      }

      tx.update(productRef, {
        'totalStock': totalStock - quantity,
        'reservedStock': reservedStock - quantity,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      tx.update(resRef, {
        'status': 'committed',
        'committedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  /// ---------------------------------------------------
  /// RELEASE RESERVATION (FAIL / CANCEL / TIMEOUT)
  /// ---------------------------------------------------
  Future<void> releaseReservation(String reservationId) async {
    await _firestore.runTransaction((tx) async {
      final resRef = _reservations.doc(reservationId);
      final resSnap = await tx.get(resRef);

      if (!resSnap.exists) return;

      final data = resSnap.data()!;
      if (data['status'] != 'active') return;

      await _releaseInternal(tx, resRef, data);
    });
  }

  /// ---------------------------------------------------
  /// INTERNAL SAFE RELEASE
  /// ---------------------------------------------------
  Future<void> _releaseInternal(
    Transaction tx,
    DocumentReference<Map<String, dynamic>> resRef,
    Map<String, dynamic> data,
  ) async {
    final String productId = data['productId'];
    final int quantity = data['quantity'];

    final productRef = _products.doc(productId);
    final productSnap = await tx.get(productRef);
    if (!productSnap.exists) return;

    final product = productSnap.data()!;
    final int reservedStock = product['reservedStock'];

    if (reservedStock < quantity) {
      throw Exception('Invalid reservedStock during release');
    }

    tx.update(productRef, {
      'reservedStock': reservedStock - quantity,
      'updatedAt': FieldValue.serverTimestamp(),
    });

    tx.update(resRef, {
      'status': 'released',
      'releasedAt': FieldValue.serverTimestamp(),
    });
  }
}
