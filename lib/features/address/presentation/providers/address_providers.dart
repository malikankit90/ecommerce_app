import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_app/features/auth/presentation/providers/auth_providers.dart';
import '../../data/models/address_model.dart';
import '../../data/repositories/address_repository.dart';
import '../../data/services/address_firestore_service.dart';

/// =======================================================
/// Service Providers
/// =======================================================

final addressFirestoreServiceProvider = Provider<AddressFirestoreService>((ref) {
  return AddressFirestoreService();
});

/// =======================================================
/// Repository Provider
/// =======================================================

final addressRepositoryProvider = Provider<AddressRepository>((ref) {
  return AddressRepository(
    firestoreService: ref.read(addressFirestoreServiceProvider),
  );
});

/// =======================================================
/// Addresses Stream
/// =======================================================

final addressesStreamProvider =
    StreamProvider<List<AddressModel>>((ref) async* {
  final authState = await ref.watch(authStateProvider.future);

  if (authState == null) {
    yield [];
    return;
  }

  yield* ref.read(addressRepositoryProvider).getAddressesStream(authState.uid);
});

/// =======================================================
/// Default Address
/// =======================================================

final defaultAddressProvider = FutureProvider<AddressModel?>((ref) async {
  final authState = await ref.watch(authStateProvider.future);

  if (authState == null) {
    return null;
  }

  return ref.read(addressRepositoryProvider).getDefaultAddress(authState.uid);
});

/// =======================================================
/// Address Controller
/// =======================================================

final addressControllerProvider =
    StateNotifierProvider<AddressController, AsyncValue<void>>((ref) {
  return AddressController(
    addressRepository: ref.read(addressRepositoryProvider),
    ref: ref,
  );
});

class AddressController extends StateNotifier<AsyncValue<void>> {
  final AddressRepository _addressRepository;
  final Ref _ref;

  AddressController({
    required AddressRepository addressRepository,
    required Ref ref,
  })  : _addressRepository = addressRepository,
        _ref = ref,
        super(const AsyncValue.data(null));

  String? get _userId {
    final authState = _ref.read(authStateProvider).value;
    return authState?.uid;
  }

  /// ---------------------------------------------------
  /// Create address
  /// ---------------------------------------------------
  Future<void> createAddress(AddressModel address) async {
    final userId = _userId;
    if (userId == null) {
      state = AsyncValue.error('User not authenticated', StackTrace.current);
      return;
    }

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _addressRepository.createAddress(userId, address);
    });
  }

  /// ---------------------------------------------------
  /// Update address
  /// ---------------------------------------------------
  Future<void> updateAddress(
    String addressId,
    Map<String, dynamic> data,
  ) async {
    final userId = _userId;
    if (userId == null) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _addressRepository.updateAddress(userId, addressId, data);
    });
  }

  /// ---------------------------------------------------
  /// Delete address
  /// ---------------------------------------------------
  Future<void> deleteAddress(String addressId) async {
    final userId = _userId;
    if (userId == null) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _addressRepository.deleteAddress(userId, addressId);
    });
  }

  /// ---------------------------------------------------
  /// Set default address
  /// ---------------------------------------------------
  Future<void> setDefaultAddress(String addressId) async {
    final userId = _userId;
    if (userId == null) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _addressRepository.setDefaultAddress(userId, addressId);
    });
  }
}