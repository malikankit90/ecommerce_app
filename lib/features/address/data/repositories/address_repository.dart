import '../models/address_model.dart';
import '../services/address_firestore_service.dart';

class AddressRepository {
  final AddressFirestoreService _firestoreService;

  AddressRepository({
    required AddressFirestoreService firestoreService,
  }) : _firestoreService = firestoreService;

  // =====================================================
  // Addresses - Read
  // =====================================================

  Stream<List<AddressModel>> getAddressesStream(String userId) {
    try {
      return _firestoreService.getAddressesStream(userId);
    } catch (e) {
      throw Exception('Failed to stream addresses: $e');
    }
  }

  Future<List<AddressModel>> getAddresses(String userId) async {
    try {
      return await _firestoreService.getAddresses(userId);
    } catch (e) {
      throw Exception('Failed to get addresses: $e');
    }
  }

  Future<AddressModel?> getDefaultAddress(String userId) async {
    try {
      return await _firestoreService.getDefaultAddress(userId);
    } catch (e) {
      throw Exception('Failed to get default address: $e');
    }
  }

  // =====================================================
  // Addresses - Write
  // =====================================================

  Future<void> createAddress(String userId, AddressModel address) async {
    try {
      await _firestoreService.createAddress(userId, address);
    } catch (e) {
      throw Exception('Failed to create address: $e');
    }
  }

  Future<void> updateAddress(
    String userId,
    String addressId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestoreService.updateAddress(userId, addressId, data);
    } catch (e) {
      throw Exception('Failed to update address: $e');
    }
  }

  Future<void> deleteAddress(String userId, String addressId) async {
    try {
      await _firestoreService.deleteAddress(userId, addressId);
    } catch (e) {
      throw Exception('Failed to delete address: $e');
    }
  }

  Future<void> setDefaultAddress(String userId, String addressId) async {
    try {
      await _firestoreService.setDefaultAddress(userId, addressId);
    } catch (e) {
      throw Exception('Failed to set default address: $e');
    }
  }
}