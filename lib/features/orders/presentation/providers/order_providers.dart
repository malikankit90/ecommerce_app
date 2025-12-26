import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:ecommerce_app/features/auth/presentation/providers/auth_providers.dart';

import '../../data/models/order_model.dart';
import '../../data/repositories/order_repository.dart';
import '../../data/services/order_firestore_service.dart';

/// =======================================================
/// Service Provider
/// =======================================================

final orderFirestoreServiceProvider = Provider<OrderFirestoreService>((ref) {
  return OrderFirestoreService();
});

/// =======================================================
/// Repository Provider
/// =======================================================

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository(
    firestoreService: ref.read(orderFirestoreServiceProvider),
  );
});

/// =======================================================
/// User Orders Stream
/// =======================================================

final userOrdersStreamProvider =
    StreamProvider.autoDispose<List<OrderModel>>((ref) async* {
  final authState = await ref.watch(authStateProvider.future);

  if (authState == null) {
    debugPrint('🟡 userOrdersStreamProvider → authState null');
    yield [];
    return;
  }

  debugPrint('🟢 userOrdersStreamProvider → uid=${authState.uid}');
  yield* ref.read(orderRepositoryProvider).getUserOrdersStream(authState.uid);
});

/// =======================================================
/// Order By ID Stream
/// =======================================================

final orderByIdProvider =
    StreamProvider.family.autoDispose<OrderModel?, String>(
  (ref, orderId) async* {
    final authState = await ref.watch(authStateProvider.future);

    if (authState == null) {
      debugPrint('🔴 orderByIdProvider → authState null');
      yield null;
      return;
    }

    if (orderId.isEmpty) {
      debugPrint('🔴 orderByIdProvider → EMPTY orderId');
      yield null;
      return;
    }

    debugPrint('🟢 orderByIdProvider → listening orderId=$orderId');
    yield* ref.read(orderRepositoryProvider).getOrderStream(orderId);
  },
);

/// =======================================================
/// Order Controller (IDEMPOTENT)
/// =======================================================

final orderControllerProvider =
    StateNotifierProvider<OrderController, AsyncValue<String?>>((ref) {
  return OrderController(
    orderRepository: ref.read(orderRepositoryProvider),
  );
});

class OrderController extends StateNotifier<AsyncValue<String?>> {
  final OrderRepository _orderRepository;

  /// Guards idempotency at controller level
  Future<String>? _inFlightCreate;
  String? _lastCreatedOrderId;

  OrderController({
    required OrderRepository orderRepository,
  })  : _orderRepository = orderRepository,
        super(const AsyncValue.data(null));

  /// ---------------------------------------------------
  /// CREATE ORDER (IDEMPOTENT – SAFE TO RETRY)
  /// ---------------------------------------------------
  Future<String> createOrder(OrderModel order) {
    // ✅ Already created → return cached ID
    if (_lastCreatedOrderId != null) {
      debugPrint(
        '🟡 createOrder() → returning cached orderId=$_lastCreatedOrderId',
      );
      return Future.value(_lastCreatedOrderId);
    }

    // ✅ Already in progress → return same Future
    if (_inFlightCreate != null) {
      debugPrint('🟡 createOrder() → reusing in-flight request');
      return _inFlightCreate!;
    }

    debugPrint('🟢 createOrder() START');
    debugPrint('   ↳ userId=${order.userId}');
    debugPrint('   ↳ orderNumber=${order.orderNumber}');
    debugPrint('   ↳ idempotencyKey(order.id)=${order.id}');

    state = const AsyncValue.loading();

    _inFlightCreate = _createInternal(order);
    return _inFlightCreate!;
  }

  Future<String> _createInternal(OrderModel order) async {
    try {
      final orderId = await _orderRepository.createOrder(order);

      debugPrint('✅ createOrder() SUCCESS → orderId=$orderId');

      _lastCreatedOrderId = orderId;
      state = AsyncValue.data(orderId);

      return orderId;
    } catch (e, st) {
      debugPrint('🔴 createOrder() FAILED → $e');
      debugPrintStack(stackTrace: st);

      _inFlightCreate = null;
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  /// ---------------------------------------------------
  /// CANCEL ORDER
  /// ---------------------------------------------------
  Future<void> cancelOrder(String orderId) async {
    state = const AsyncValue.loading();

    try {
      debugPrint('🟡 cancelOrder() → orderId=$orderId');

      await _orderRepository.cancelOrder(orderId);

      debugPrint('✅ cancelOrder() SUCCESS');
      state = const AsyncValue.data(null);
    } catch (e, st) {
      debugPrint('🔴 cancelOrder() FAILED → $e');
      debugPrintStack(stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  /// ---------------------------------------------------
  /// Generate Order Number
  /// ---------------------------------------------------
  Future<String> generateOrderNumber() async {
    final number = await _orderRepository.generateOrderNumber();
    debugPrint('🟢 generateOrderNumber() → $number');
    return number;
  }

  /// ---------------------------------------------------
  /// RESET (e.g. logout)
  /// ---------------------------------------------------
  void reset() {
    debugPrint('🟡 OrderController.reset()');
    _inFlightCreate = null;
    _lastCreatedOrderId = null;
    state = const AsyncValue.data(null);
  }
}
