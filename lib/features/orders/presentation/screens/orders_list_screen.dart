import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/order_providers.dart';
import '../../data/models/order_model.dart';
import 'package:ecommerce_app/features/auth/presentation/providers/auth_providers.dart';

class OrdersListScreen extends ConsumerWidget {
  const OrdersListScreen({super.key});

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

        final ordersAsync = ref.watch(userOrdersStreamProvider);

        return Scaffold(
          appBar: AppBar(title: const Text('My Orders')),
          body: ordersAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text('Failed to load orders'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => ref.invalidate(userOrdersStreamProvider),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
            data: (orders) {
              if (orders.isEmpty) {
                return _EmptyOrders(context);
              }

              return RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(userOrdersStreamProvider);
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return _OrderCard(order: orders[index]);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// =======================================================
// ORDER CARD
// =======================================================

class _OrderCard extends StatelessWidget {
  final OrderModel order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.push('/orders/${order.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order #${order.orderNumber}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDate(order.createdAt),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusChip(order.status),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${order.totalItems} ${order.totalItems == 1 ? 'item' : 'items'}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    '\$${order.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              if (order.trackingNumber != null) ...[
                const SizedBox(height: 12),
                _TrackingBadge(order.trackingNumber!),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // STATUS CHIP
  // =====================================================

  Widget _buildStatusChip(String status) {
    Color color;
    IconData icon;
    String label;

    switch (status) {
      case 'payment_pending':
        color = Colors.orange;
        icon = Icons.pending;
        label = 'Payment Pending';
        break;
      case 'confirmed':
        color = Colors.blue;
        icon = Icons.check_circle;
        label = 'Confirmed';
        break;
      case 'processing':
        color = Colors.purple;
        icon = Icons.autorenew;
        label = 'Processing';
        break;
      case 'shipped':
        color = Colors.teal;
        icon = Icons.local_shipping;
        label = 'Shipped';
        break;
      case 'delivered':
        color = Colors.green;
        icon = Icons.done_all;
        label = 'Delivered';
        break;
      case 'cancelled':
        color = Colors.red;
        icon = Icons.cancel;
        label = 'Cancelled';
        break;
      default:
        color = Colors.grey;
        icon = Icons.help;
        label = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  static String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.day}/${date.month}/${date.year}';
  }
}

// =======================================================
// SMALL UI HELPERS
// =======================================================

class _TrackingBadge extends StatelessWidget {
  final String tracking;

  const _TrackingBadge(this.tracking);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.local_shipping, size: 16, color: Colors.blue.shade700),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Tracking: $tracking',
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _EmptyOrders(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.shopping_bag_outlined, size: 100, color: Colors.grey[300]),
        const SizedBox(height: 24),
        Text(
          'No orders yet',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Start shopping to create your first order',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () => context.go('/products'),
          child: const Text('Browse Products'),
        ),
      ],
    ),
  );
}
