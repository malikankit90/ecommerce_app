import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/wishlist_providers.dart';
import '../../../cart/presentation/providers/cart_providers.dart';
import '../../../cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app/features/auth/presentation/providers/auth_providers.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

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

        final wishlistItemsAsync = ref.watch(wishlistItemsStreamProvider);

        return Scaffold(
          appBar: AppBar(
            title: const Text('My Wishlist'),
          ),
          body: wishlistItemsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) =>
                const Center(child: Text('Failed to load wishlist')),
            data: (items) {
              if (items.isEmpty) {
                return const Center(child: Text('Wishlist is empty'));
              }

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _WishlistCard(item: items[index]);
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _WishlistCard extends ConsumerWidget {
  final dynamic item;

  const _WishlistCard({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => context.push('/products/${item.productId}'),
            child: SizedBox(
              height: 160,
              width: double.infinity,
              child: Image.network(
                item.thumbnailUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.image_not_supported),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: item.inStock
                          ? () => _handleAddToCart(context, ref, item)
                          : null,
                      child: Text(
                        item.inStock ? 'Add to Cart' : 'Out of Stock',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleAddToCart(
    BuildContext context,
    WidgetRef ref,
    dynamic item,
  ) async {
    final authState = ref.read(authStateProvider).value;
    if (authState == null) return;

    final cartItem = CartItemModel(
      id: '${authState.uid}_${item.productId}_${DateTime.now().millisecondsSinceEpoch}',
      userId: authState.uid,
      productId: item.productId,
      productName: item.productName,
      productSlug: item.productSlug,
      brandName: item.brandName,
      thumbnailUrl: item.thumbnailUrl,
      price: item.price,
      compareAtPrice: item.compareAtPrice,
      quantity: 1,
    );

    await ref.read(cartControllerProvider.notifier).addToCart(cartItem);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added to cart')),
      );
    }
  }
}
