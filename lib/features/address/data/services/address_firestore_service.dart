import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/address_model.dart';

class AddressFirestoreService {
  final _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _addresses(String userId) =>
      _firestore.collection('users').doc(userId).collection('addresses');

  // =====================================================
  // Addresses
  // =====================================================

  Future<void> createAddress(String userId, AddressModel address) async {
    await _addresses(userId).doc(address.id).set(address.toFirestore());
  }

  Future<void> updateAddress(
    String userId,
    String addressId,
    Map<String, dynamic> data,
  ) async {
    await _addresses(userId).doc(addressId).update({
      ...data,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteAddress(String userId, String addressId) async {
    await _addresses(userId).doc(addressId).update({
      'isDeleted': true,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> setDefaultAddress(String userId, String addressId) async {
    final batch = _firestore.batch();
    
    // Remove default from all addresses
    final allAddresses = await _addresses(userId)
        .where('isDeleted', isEqualTo: false)
        .get();
    
    for (var doc in allAddresses.docs) {
      batch.update(doc.reference, {'isDefault': false});
    }
    
    // Set new default
    batch.update(_addresses(userId).doc(addressId), {'isDefault': true});
    
    await batch.commit();
  }

  Stream<List<AddressModel>> getAddressesStream(String userId) {
    return _addresses(userId)
        .where('isDeleted', isEqualTo: false)
        .orderBy('isDefault', descending: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AddressModel.fromFirestore(doc))
          .toList();
    });
  }

  Future<List<AddressModel>> getAddresses(String userId) async {
    final snapshot = await _addresses(userId)
        .where('isDeleted', isEqualTo: false)
        .orderBy('isDefault', descending: true)
        .orderBy('createdAt', descending: true)
        .get();
    
    return snapshot.docs
        .map((doc) => AddressModel.fromFirestore(doc))
        .toList();
  }

  Future<AddressModel?> getDefaultAddress(String userId) async {
    final snapshot = await _addresses(userId)
        .where('isDeleted', isEqualTo: false)
        .where('isDefault', isEqualTo: true)
        .limit(1)
        .get();
    
    if (snapshot.docs.isEmpty) return null;
    return AddressModel.fromFirestore(snapshot.docs.first);
  }
}