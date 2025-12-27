import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_functions/cloud_functions.dart';

import 'package:ecommerce_app/features/auth/presentation/providers/auth_providers.dart';

import '../../data/models/order_model.dart';
import '../../data/services/order_firestore_service.dart';

import '../../../cart/presentation/providers/cart_providers.dart';
import '../../../address/data/models/address_model.dart';

import '../../../stock/data/repositories/stock_repository.dart';
import '../../../stock/data/services/stock_firestore_service.dart'; // ✅ REQUIRED
import '../../../stock/presentation/providers/stock_providers.dart';

/// =======================================================
/// READ-ONLY FIRESTORE SERVICE
/// =======================================================

final orderFirestoreServiceProvider = Provider<OrderFirestoreService>((ref) {
  return OrderFirestoreService();
});

/// =======================================================
/// USER ORDERS STREAM (READ ONLY)
/// =======================================================

final userOrdersStreamProvider =
    StreamProvider.autoDispose<List<OrderModel>>((ref) async* {
  final user = await ref.watch(authStateProvider.future);
  if (user == null) {
    yield [];
    return;
  }

  yield* ref.read(orderFirestoreServiceProvider).getUserOrdersStream(user.uid);
});

/// =======================================================
/// SINGLE ORDER STREAM (READ ONLY)
/// =======================================================

final orderByIdProvider =
    StreamProvider.family.autoDispose<OrderModel?, String>(
  (ref, orderId) async* {
    final user = await ref.watch(authStateProvider.future);
    if (user == null || orderId.isEmpty) {
      yield null;
      return;
    }

    yield* ref.read(orderFirestoreServiceProvider).getOrderStream(orderId);
  },
);

/// =======================================================
/// ORDER CONTROLLER (WRITE = CLOUD FUNCTIONS ONLY)
/// =======================================================

final orderControllerProvider =
    StateNotifierProvider<OrderController, AsyncValue<String?>>((ref) {
  return OrderController(
    stockRepository: ref.read(stockRepositoryProvider),
    ref: ref,
  );
});

class OrderController extends StateNotifier<AsyncValue<String?>> {
  final StockRepository _stockRepository;
  final Ref _ref;

  Future<String>? _inFlight;
  String? _lastOrderId;

  OrderController({
    required StockRepository stockRepository,
    required Ref ref,
  })  : _stockRepository = stockRepository,
        _ref = ref,
        super(const AsyncValue.data(null));

  // =====================================================
  // CREATE ORDER (CF ONLY)
  // =====================================================

  Future<String> createOrder({
    required String idempotencyKey,
    required AddressModel address,
    required String paymentMethod,
    String? note,
  }) {
    if (_lastOrderId != null) {
      return Future.value(_lastOrderId);
    }

    if (_inFlight != null) {
      return _inFlight!;
    }

    state = const AsyncValue.loading();
    _inFlight = _createInternal(
      idempotencyKey: idempotencyKey,
      address: address,
      paymentMethod: paymentMethod,
      note: note,
    );

    return _inFlight!;
  }

  Future<String> _createInternal({
    required String idempotencyKey,
    required AddressModel address,
    required String paymentMethod,
    String? note,
  }) async {
    try {
      final user = await _ref.read(authStateProvider.future);
      if (user == null) {
        throw StateError('User not authenticated');
      }

      final cartItems = _ref.read(cartItemsStreamProvider).valueOrNull;
      if (cartItems == null || cartItems.isEmpty) {
        throw StateError('Cart is empty');
      }

      debugPrint('🟢 reserveStock (CF)');

      // ✅ STRONGLY TYPED LIST
      final List<ReservedStockItem> items = cartItems
          .map(
            (item) => ReservedStockItem(
              productId: item.productId,
              quantity: item.quantity,
            ),
          )
          .toList();

      final reservationIds = await _stockRepository.reserveStockForOrder(
        orderId: idempotencyKey,
        items: items,
      );

      debugPrint('🟢 createOrder (CF)');

      final callable = FirebaseFunctions.instanceFor(
        region: 'us-central1',
      ).httpsCallable('createOrder');

      final result = await callable.call({
        'idempotencyKey': idempotencyKey,
        'reservationIds': reservationIds,
        'paymentMethod': paymentMethod,
        'customerNote': note ?? '',
        'shippingAddress': address.toCallableJson(),
      });

      final orderId = result.data['orderId'] as String;

      _lastOrderId = orderId;
      state = AsyncValue.data(orderId);
      return orderId;
    } catch (e, st) {
      _inFlight = null;
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  // =====================================================
  // CANCEL (CF INTENT ONLY)
  // =====================================================

  Future<void> cancelOrder(String orderId) async {
    final callable = FirebaseFunctions.instanceFor(
      region: 'us-central1',
    ).httpsCallable('cancelOrder');

    await callable.call({'orderId': orderId});
  }

  void reset() {
    _inFlight = null;
    _lastOrderId = null;
    state = const AsyncValue.data(null);
  }
}
