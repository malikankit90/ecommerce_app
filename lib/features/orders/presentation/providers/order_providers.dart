import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    yield [];
    return;
  }

  yield* ref
      .read(orderRepositoryProvider)
      .getUserOrdersStream(authState.uid);
});

/// =======================================================
/// Order By ID Stream
/// =======================================================

final orderByIdProvider =
    StreamProvider.family.autoDispose<OrderModel?, String>(
  (ref, orderId) async* {
    final authState = await ref.watch(authStateProvider.future);

    if (authState == null) {
      yield null;
      return;
    }

    yield* ref
        .read(orderRepositoryProvider)
        .getOrderStream(orderId);
  },
);

/// =======================================================
/// Order Controller
/// =======================================================

final orderControllerProvider =
    StateNotifierProvider<OrderController, AsyncValue<void>>((ref) {
  return OrderController(
    orderRepository: ref.read(orderRepositoryProvider),
  );
});

class OrderController extends StateNotifier<AsyncValue<void>> {
  final OrderRepository _orderRepository;

  OrderController({
    required OrderRepository orderRepository,
  })  : _orderRepository = orderRepository,
        super(const AsyncValue.data(null));

  /// ---------------------------------------------------
  /// Create Order
  /// ---------------------------------------------------
  Future<String> createOrder(OrderModel order) async {
    state = const AsyncValue.loading();

    try {
      await _orderRepository.createOrder(order);
      state = const AsyncValue.data(null);
      return order.id;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow; // 🔥 DO NOT hide failures
    }
  }

  /// ---------------------------------------------------
  /// Cancel Order
  /// ---------------------------------------------------
  Future<void> cancelOrder(String orderId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _orderRepository.cancelOrder(orderId);
    });
  }

  /// ---------------------------------------------------
  /// Generate Order Number
  /// ---------------------------------------------------
  Future<String> generateOrderNumber() async {
    return await _orderRepository.generateOrderNumber();
  }
}
