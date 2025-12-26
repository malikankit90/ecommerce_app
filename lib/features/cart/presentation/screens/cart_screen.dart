import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/cart_providers.dart';
import 'package:ecommerce_app/features/auth/presentation/providers/auth_providers.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

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

        final cartItemsAsync = ref.watch(cartItemsStreamProvider);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Shopping Cart'),
            actions: [
              cartItemsAsync.when(
                data: (items) => items.isNotEmpty
                    ? TextButton(
                        onPressed: () => _showClearCartDialog(context, ref),
                        child: const Text('Clear'),
                      )
                    : const SizedBox.shrink(),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ],
          ),
          body: cartItemsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const Center(child: Text('Failed to load cart')),
            data: (items) {
              if (items.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 100,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Your cart is empty',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
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

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return _CartItemCard(item: items[index]);
                      },
                    ),
                  ),
                  const _CartSummary(),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _showClearCartDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text(
            'Are you sure you want to remove all items from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(cartControllerProvider.notifier).clearCart();
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _CartItemCard extends ConsumerWidget {
  final dynamic item;

  const _CartItemCard({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => context.push('/products/${item.productId}'),
              child: SizedBox(
                width: 80,
                height: 80,
                child: Image.network(
                  item.thumbnailUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image_not_supported),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.brandName,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (item.variantDisplay.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      item.variantDisplay,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      if (item.hasDiscount) ...[
                        const SizedBox(width: 8),
                        Text(
                          '\$${item.compareAtPrice!.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: item.quantity > 1
                            ? () {
                                ref
                                    .read(cartControllerProvider.notifier)
                                    .updateQuantity(item.id, item.quantity - 1);
                              }
                            : null,
                      ),
                      Text(
                        '${item.quantity}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          ref
                              .read(cartControllerProvider.notifier)
                              .updateQuantity(item.id, item.quantity + 1);
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        icon:
                            const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          ref
                              .read(cartControllerProvider.notifier)
                              .removeFromCart(item.id);
                        },
                      ),
                    ],
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

class _CartSummary extends ConsumerWidget {
  const _CartSummary();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totals = ref.watch(cartTotalsProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _row('Subtotal', totals['subtotal']!),
          if (totals['savings']! > 0)
            _row('Savings', -totals['savings']!, color: Colors.green),
          const Divider(),
          _row(
            'Total',
            totals['total']!,
            bold: true,
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.push('/checkout'),
              child: const Text('Proceed to Checkout'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(
    String label,
    double value, {
    bool bold = false,
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: bold ? 18 : 16,
                fontWeight: bold ? FontWeight.bold : null)),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: bold ? 18 : 16,
            fontWeight: bold ? FontWeight.bold : null,
            color: color,
          ),
        ),
      ],
    );
  }
}
