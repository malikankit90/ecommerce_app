import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/order_providers.dart';
import 'package:ecommerce_app/features/auth/presentation/providers/auth_providers.dart';
import '../../data/models/order_model.dart';

class OrderDetailScreen extends ConsumerWidget {
  final String orderId;

  const OrderDetailScreen({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      loading: () => const _LoadingScaffold(),
      error: (error, _) => _ErrorScaffold('Auth error: $error'),
      data: (user) {
        if (user == null) {
          return const _LoadingScaffold();
        }

        final orderAsync = ref.watch(orderByIdProvider(orderId));

        return orderAsync.when(
          loading: () => const _LoadingScaffold(),
          error: (_, __) => const _ErrorScaffold('Failed to load order'),
          data: (order) {
            if (order == null) {
              return const _ErrorScaffold('Order not found');
            }

            return Scaffold(
              appBar: AppBar(
                title: Text('Order #${order.orderNumber}'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _StatusCard(order),
                    _section('Order Items'),
                    ...order.items.map(
                      (item) => _OrderItemTile(item),
                    ),
                    _section('Shipping Address'),
                    _AddressCard(order.shippingAddress),
                    _section('Payment Summary'),
                    _PaymentSummary(order),
                    if (order.customerNote != null &&
                        order.customerNote!.isNotEmpty) ...[
                      _section('Order Note'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          order.customerNote!,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ],
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // =====================================================
  // SECTION HEADER
  // =====================================================

  Widget _section(String title) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
}

// =======================================================
// STATUS CARD
// =======================================================

class _StatusCard extends StatelessWidget {
  final OrderModel order;

  const _StatusCard(this.order);

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(order.status);

    return Card(
      margin: const EdgeInsets.all(16),
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(_statusIcon(order.status), color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.statusDisplay,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _statusMessage(order.status),
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =======================================================
// ORDER ITEM
// =======================================================

class _OrderItemTile extends StatelessWidget {
  final OrderItemModel item;

  const _OrderItemTile(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Image.network(
          item.thumbnailUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
        ),
        title: Text(
          item.productName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          'Qty: ${item.quantity} × \$${item.price.toStringAsFixed(2)}',
        ),
        trailing: Text(
          '\$${(item.price * item.quantity).toStringAsFixed(2)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        onTap: () => context.push('/products/${item.productId}'),
      ),
    );
  }
}

// =======================================================
// ADDRESS
// =======================================================

class _AddressCard extends StatelessWidget {
  final ShippingAddressModel address;

  const _AddressCard(this.address);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          '${address.fullName}\n'
          '${address.addressLine1}\n'
          '${address.city}, ${address.state}',
        ),
      ),
    );
  }
}

// =======================================================
// PAYMENT SUMMARY
// =======================================================

class _PaymentSummary extends StatelessWidget {
  final OrderModel order;

  const _PaymentSummary(this.order);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _row('Payment Method', order.paymentMethod.toUpperCase()),
          _row('Payment Status', _cap(order.paymentStatus)),
          const Divider(),
          _row('Subtotal', '\$${order.subtotal.toStringAsFixed(2)}'),
          _row('Shipping', '\$${order.shippingCost.toStringAsFixed(2)}'),
          _row('Tax', '\$${order.tax.toStringAsFixed(2)}'),
          const Divider(),
          _row('Total', '\$${order.total.toStringAsFixed(2)}', bold: true),
        ],
      ),
    );
  }

  Widget _row(String l, String v, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(l, style: TextStyle(fontWeight: bold ? FontWeight.bold : null)),
        Text(
          v,
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// =======================================================
// HELPERS
// =======================================================

Color _statusColor(String status) {
  switch (status) {
    case 'payment_pending':
      return Colors.orange;
    case 'confirmed':
      return Colors.blue;
    case 'processing':
      return Colors.purple;
    case 'shipped':
      return Colors.teal;
    case 'delivered':
      return Colors.green;
    case 'cancelled':
      return Colors.red;
    default:
      return Colors.grey;
  }
}

IconData _statusIcon(String status) {
  switch (status) {
    case 'payment_pending':
      return Icons.pending;
    case 'confirmed':
      return Icons.check_circle;
    case 'processing':
      return Icons.autorenew;
    case 'shipped':
      return Icons.local_shipping;
    case 'delivered':
      return Icons.done_all;
    case 'cancelled':
      return Icons.cancel;
    default:
      return Icons.help;
  }
}

String _statusMessage(String status) {
  switch (status) {
    case 'payment_pending':
      return 'Awaiting confirmation';
    case 'confirmed':
      return 'Order confirmed';
    case 'processing':
      return 'Preparing order';
    case 'shipped':
      return 'Order shipped';
    case 'delivered':
      return 'Order delivered';
    case 'cancelled':
      return 'Order cancelled';
    default:
      return 'Unknown status';
  }
}

String _cap(String text) =>
    text.isEmpty ? text : text[0].toUpperCase() + text.substring(1);

// =======================================================
// SMALL SCAFFOLDS
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
