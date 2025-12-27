import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../cart/presentation/providers/cart_providers.dart';
import '../../../address/presentation/providers/address_providers.dart';
import '../../../address/data/models/address_model.dart';
import '../../../orders/presentation/providers/order_providers.dart';

/// =======================================================
/// UI STATE (CHECKOUT SESSION ONLY)
/// =======================================================

final selectedAddressProvider = StateProvider<AddressModel?>((ref) => null);
final selectedPaymentMethodProvider = StateProvider<String>((ref) => 'cod');

/// Stable idempotency key for THIS checkout attempt
final checkoutIdempotencyKeyProvider = StateProvider<String?>((ref) => null);

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      loading: () => const _LoadingScaffold(),
      error: (e, _) => _ErrorScaffold('Auth error: $e'),
      data: (user) {
        if (user == null) {
          return const _LoadingScaffold();
        }

        final cartItemsAsync = ref.watch(cartItemsStreamProvider);
        final addressesAsync = ref.watch(addressesStreamProvider);

        return Scaffold(
          appBar: AppBar(title: const Text('Checkout')),
          body: cartItemsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (cartItems) {
              if (cartItems.isEmpty) {
                return _EmptyCart(context);
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _section('Shipping Address'),
                    _addressSection(addressesAsync),
                    _section('Payment Method'),
                    _paymentMethod(),
                    _section('Order Notes (Optional)'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _noteController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: 'Special instructions…',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    _section('Order Summary'),
                    _summary(cartItems),
                    const SizedBox(height: 120),
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: _bottomBar(),
        );
      },
    );
  }

  // =====================================================
  // UI HELPERS
  // =====================================================

  Widget _section(String title) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );

  Widget _addressSection(AsyncValue<List<AddressModel>> addressesAsync) {
    return addressesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) =>
          Padding(padding: const EdgeInsets.all(16), child: Text('$e')),
      data: (addresses) {
        if (addresses.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () => context.push('/addresses/add'),
              child: const Text('Add Shipping Address'),
            ),
          );
        }

        final selected = ref.watch(selectedAddressProvider);

        if (selected == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(selectedAddressProvider.notifier).state =
                addresses.firstWhere(
              (a) => a.isDefault,
              orElse: () => addresses.first,
            );
          });
        }

        return Column(
          children: addresses.map((address) {
            return RadioListTile<String>(
              value: address.id,
              groupValue: selected?.id,
              onChanged: (_) =>
                  ref.read(selectedAddressProvider.notifier).state = address,
              title: Text(address.fullName),
              subtitle: Text(address.shortAddress),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _paymentMethod() {
    final method = ref.watch(selectedPaymentMethodProvider);
    return RadioListTile<String>(
      value: 'cod',
      groupValue: method,
      onChanged: (v) =>
          ref.read(selectedPaymentMethodProvider.notifier).state = v!,
      title: const Text('Cash on Delivery'),
    );
  }

  Widget _summary(List cartItems) {
    final totals = ref.watch(cartTotalsProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...cartItems.map(
            (item) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${item.productName} × ${item.quantity}'),
                Text('\$${item.subtotal.toStringAsFixed(2)}'),
              ],
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                '\$${totals['total']!.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bottomBar() {
    final totals = ref.watch(cartTotalsProvider);
    final orderState = ref.watch(orderControllerProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: orderState.isLoading ? null : _placeOrder,
          child: orderState.isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text('Place Order • \$${totals['total']!.toStringAsFixed(2)}'),
        ),
      ),
    );
  }

  // =====================================================
  // ORDER SUBMISSION (UI → CONTROLLER)
  // =====================================================

  Future<void> _placeOrder() async {
    final address = ref.read(selectedAddressProvider);
    final cartItems = ref.read(cartItemsStreamProvider).value;
    final auth = ref.read(authStateProvider).value;

    if (address == null ||
        cartItems == null ||
        cartItems.isEmpty ||
        auth == null) {
      _snack('Missing checkout information');
      return;
    }

    // Stable per-session idempotency key
    var key = ref.read(checkoutIdempotencyKeyProvider);
    key ??= '${auth.uid}_${DateTime.now().microsecondsSinceEpoch}';
    ref.read(checkoutIdempotencyKeyProvider.notifier).state = key;

    try {
      final orderId =
          await ref.read(orderControllerProvider.notifier).createOrder(
                idempotencyKey: key,
                address: address,
                note: _noteController.text.trim(),
                paymentMethod: ref.read(selectedPaymentMethodProvider),
              );

      await ref.read(cartControllerProvider.notifier).clearCart();
      ref.read(checkoutIdempotencyKeyProvider.notifier).state = null;

      if (mounted) {
        context.go('/orders/$orderId/success');
      }
    } catch (e) {
      _snack('Order failed: $e');
    }
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

// =======================================================
// SMALL UI HELPERS
// =======================================================

class _LoadingScaffold extends StatelessWidget {
  const _LoadingScaffold();

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: CircularProgressIndicator()));
}

class _ErrorScaffold extends StatelessWidget {
  final String message;
  const _ErrorScaffold(this.message);

  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text(message)));
}

Widget _EmptyCart(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Your cart is empty'),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Continue Shopping'),
        ),
      ],
    ),
  );
}
