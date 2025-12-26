import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/product_providers.dart';
import 'package:ecommerce_app/features/auth/presentation/providers/auth_providers.dart';
import '../../../cart/presentation/providers/cart_providers.dart';
import '../../../cart/data/models/cart_item_model.dart';

// ✅ WISHLIST IMPORTS
import '../../../wishlist/presentation/providers/wishlist_providers.dart';
import '../../../wishlist/data/models/wishlist_item_model.dart';

class ProductDetailScreen extends ConsumerWidget {
  final String productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
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

        final productAsync = ref.watch(productByIdProvider(productId));

        return productAsync.when(
          loading: () => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Failed to load product')),
          ),
          data: (product) {
            if (product == null) {
              return Scaffold(
                appBar: AppBar(),
                body: const Center(child: Text('Product not found')),
              );
            }

            return _ProductDetailContent(product: product);
          },
        );
      },
    );
  }
}

class _ProductDetailContent extends ConsumerWidget {
  final dynamic product;

  const _ProductDetailContent({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final variantsAsync = ref.watch(productVariantsProvider(product.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          Consumer(
            builder: (context, ref, _) {
              final isInWishlist = ref.watch(isInWishlistProvider(product.id));

              return IconButton(
                icon: Icon(
                  isInWishlist ? Icons.favorite : Icons.favorite_border,
                  color: isInWishlist ? Colors.red : null,
                ),
                onPressed: () => _handleWishlistToggle(context, ref, product),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageGallery(product),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.brandName),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.displayPrice,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 24),
                  variantsAsync.when(
                    loading: () => const CircularProgressIndicator(),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (variants) {
                      if (variants.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      return Wrap(
                        spacing: 8,
                        children: variants
                            .map((v) => _VariantChip(variant: v))
                            .toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  Text(product.description),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: product.inStock
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () => _handleAddToCart(context, ref, product),
                  child: const Text('Add to Cart'),
                ),
              ),
            )
          : null,
    );
  }

  void _handleWishlistToggle(
    BuildContext context,
    WidgetRef ref,
    dynamic product,
  ) async {
    final authState = ref.read(authStateProvider).value;
    if (authState == null) return;

    final wishlistItem = WishlistItemModel(
      id: '${authState.uid}_${product.id}',
      userId: authState.uid,
      productId: product.id,
      productName: product.name,
      productSlug: product.slug,
      brandName: product.brandName,
      thumbnailUrl: product.thumbnailUrl,
      price: product.sellingPrice,
      compareAtPrice: product.compareAtPrice,
      inStock: product.inStock,
    );

    await ref
        .read(wishlistControllerProvider.notifier)
        .toggleWishlist(product.id, wishlistItem);
  }

  void _handleAddToCart(
    BuildContext context,
    WidgetRef ref,
    dynamic product,
  ) async {
    final authState = ref.read(authStateProvider).value;
    if (authState == null) return;

    final cartItem = CartItemModel(
      id: '${authState.uid}_${product.id}_${DateTime.now().millisecondsSinceEpoch}',
      userId: authState.uid,
      productId: product.id,
      productName: product.name,
      productSlug: product.slug,
      brandName: product.brandName,
      thumbnailUrl: product.thumbnailUrl,
      price: product.sellingPrice,
      compareAtPrice: product.compareAtPrice,
      quantity: 1,
    );

    await ref.read(cartControllerProvider.notifier).addToCart(cartItem);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Added to cart'),
          action: SnackBarAction(
            label: 'View Cart',
            onPressed: () => context.push('/cart'),
          ),
        ),
      );
    }
  }

  Widget _buildImageGallery(product) {
    if (product.images.isEmpty) {
      return const SizedBox(
        height: 300,
        child: Center(child: Icon(Icons.image)),
      );
    }

    return SizedBox(
      height: 300,
      child: PageView(
        children: product.images
            .map<Widget>(
              (img) => Image.network(img.url, fit: BoxFit.cover),
            )
            .toList(),
      ),
    );
  }
}

class _VariantChip extends StatelessWidget {
  final dynamic variant;

  const _VariantChip({required this.variant});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(variant.displayName),
      backgroundColor:
          variant.inStock ? Colors.blue.shade50 : Colors.grey.shade200,
    );
  }
}
