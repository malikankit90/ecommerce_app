import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/order_providers.dart';
import 'package:ecommerce_app/features/auth/presentation/providers/auth_providers.dart';

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
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        body: Center(child: Text('Auth error: $error')),
      ),
      data: (user) {
        if (user == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final orderAsync = ref.watch(orderByIdProvider(orderId));

        return orderAsync.when(
          loading: () => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Failed to load order')),
          ),
          data: (order) {
            if (order == null) {
              return Scaffold(
                appBar: AppBar(),
                body: const Center(child: Text('Order not found')),
              );
            }

            return Scaffold(
              appBar: AppBar(
                title: Text('Order #${order.orderNumber}'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatusCard(order),
                    _buildSectionHeader('Order Items'),
                    ...order.items.map(
                      (item) => _buildOrderItem(context, item),
                    ),
                    _buildSectionHeader('Shipping Address'),
                    _buildAddressCard(order.shippingAddress),
                    _buildSectionHeader('Payment Summary'),
                    _buildPaymentSummary(order),
                    if (order.customerNote != null) ...[
                      _buildSectionHeader('Order Note'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          order.customerNote!,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ],
                    const SizedBox(height: 100),
                  ],
                ),
              ),

              // ✅ Cancel ONLY when rules allow it
              bottomNavigationBar:
                  order.canCancel ? _buildBottomBar(context, ref, order) : null,
            );
          },
        );
      },
    );
  }

  // =====================================================
  // UI HELPERS
  // =====================================================

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildStatusCard(order) {
    return Card(
      margin: const EdgeInsets.all(16),
      color: _getStatusColor(order.status).withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: _getStatusColor(order.status).withOpacity(0.2),
              child: Icon(
                _getStatusIcon(order.status),
                color: _getStatusColor(order.status),
              ),
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
                      color: _getStatusColor(order.status),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getStatusMessage(order.status),
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

  // =====================================================
  // ORDER ITEMS
  // =====================================================

  Widget _buildOrderItem(BuildContext context, item) {
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
        title: Text(item.productName,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
          'Qty: ${item.quantity} × \$${item.price.toStringAsFixed(2)}',
        ),
        trailing: Text(
          '\$${(item.price * item.quantity).toStringAsFixed(2)}',
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        onTap: () => context.push('/products/${item.productId}'),
      ),
    );
  }

  // =====================================================
  // ADDRESS & PAYMENT
  // =====================================================

  Widget _buildAddressCard(address) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          '${address.fullName}\n${address.addressLine1}\n${address.city}, ${address.state}',
        ),
      ),
    );
  }

  Widget _buildPaymentSummary(order) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _row('Payment Method', order.paymentMethod.toUpperCase()),
          _row('Payment Status', _capitalizeFirst(order.paymentStatus)),
          const Divider(),
          _row('Subtotal', '\$${order.subtotal.toStringAsFixed(2)}'),
          _row('Shipping', '\$${order.shippingCost.toStringAsFixed(2)}'),
          _row('Tax', '\$${order.tax.toStringAsFixed(2)}'),
          const Divider(),
          _row(
            'Total',
            '\$${order.total.toStringAsFixed(2)}',
            bold: true,
          ),
        ],
      ),
    );
  }

  Widget _row(String l, String v, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(l, style: TextStyle(fontWeight: bold ? FontWeight.bold : null)),
        Text(v,
            style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.w600)),
      ],
    );
  }

  // =====================================================
  // CANCEL
  // =====================================================

  Widget _buildBottomBar(BuildContext context, WidgetRef ref, order) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: OutlinedButton(
          onPressed: () => _showCancelDialog(context, ref, order.id),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.red),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child:
              const Text('Cancel Order', style: TextStyle(color: Colors.red)),
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context, WidgetRef ref, String orderId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Cancel Order'),
        content: const Text('You can cancel this order before it is shipped.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref
                  .read(orderControllerProvider.notifier)
                  .cancelOrder(orderId);
            },
            child:
                const Text('Yes, Cancel', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // STATUS MAP (FIXED)
  // =====================================================

  Color _getStatusColor(String status) {
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

  IconData _getStatusIcon(String status) {
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

  String _getStatusMessage(String status) {
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

  String _capitalizeFirst(String text) =>
      text.isEmpty ? text : text[0].toUpperCase() + text.substring(1);
}
