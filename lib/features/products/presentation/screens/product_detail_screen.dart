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
        // 🚨 CRITICAL GUARD
        if (user == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 🔒 ONLY load product data after auth is ready
        final productAsync = ref.watch(productByIdProvider(productId));

        return productAsync.when(
          loading: () => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text('Failed to load product'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () =>
                        ref.invalidate(productByIdProvider(productId)),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
          data: (product) {
            if (product == null) {
              return Scaffold(
                appBar: AppBar(),
                body: const Center(
                  child: Text('Product not found'),
                ),
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
  final product;

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
              final isInWishlist =
                  ref.watch(isInWishlistProvider(product.id));

              return IconButton(
                icon: Icon(
                  isInWishlist
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: isInWishlist ? Colors.red : null,
                ),
                onPressed: () =>
                    _handleWishlistToggle(context, ref, product),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
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
                  Text(
                    product.brandName,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Text(
                        product.displayPrice,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      if (product.hasDiscount) ...[
                        const SizedBox(width: 12),
                        Text(
                          product.originalPrice,
                          style: TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${product.discountPercentage}% OFF',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),

                  if (product.totalReviews > 0)
                    Row(
                      children: [
                        const Icon(Icons.star,
                            color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          product.averageRating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${product.totalReviews} reviews)',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 24),

                  variantsAsync.when(
                    loading: () => const CircularProgressIndicator(),
                    error: (error, _) => const SizedBox.shrink(),
                    data: (variants) {
                      if (variants.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Available Options',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: variants.map((variant) {
                              return _VariantChip(variant: variant);
                            }).toList(),
                          ),
                          const SizedBox(height: 24),
                        ],
                      );
                    },
                  ),

                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  if (product.material.isNotEmpty ||
                      product.fit.isNotEmpty ||
                      product.origin.isNotEmpty) ...[
                    const Text(
                      'Product Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (product.material.isNotEmpty)
                      _DetailRow('Material', product.material),
                    if (product.fit.isNotEmpty)
                      _DetailRow('Fit', product.fit),
                    if (product.origin.isNotEmpty)
                      _DetailRow('Made in', product.origin),
                    const SizedBox(height: 24),
                  ],

                  if (!product.inStock)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Colors.red.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline,
                              color: Colors.red.shade700),
                          const SizedBox(width: 12),
                          Text(
                            'Out of Stock',
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            _handleAddToCart(context, ref, product),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                        ),
                        child: const Text('Add to Cart'),
                      ),
                    ),
                  ],
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
      availableStock: product.availableStock,
    );

    await ref
        .read(wishlistControllerProvider.notifier)
        .toggleWishlist(product.id, wishlistItem);

    final isInWishlist =
        ref.read(isInWishlistProvider(product.id));

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isInWishlist
                ? 'Added to wishlist'
                : 'Removed from wishlist',
          ),
        ),
      );
    }
  }

  void _handleAddToCart(
    BuildContext context,
    WidgetRef ref,
    dynamic product,
  ) async {
    final authState = ref.read(authStateProvider).value;
    if (authState == null) return;

    final cartItem = CartItemModel(
      id:
          '${authState.uid}_${product.id}_${DateTime.now().millisecondsSinceEpoch}',
      userId: authState.uid,
      productId: product.id,
      productName: product.name,
      productSlug: product.slug,
      brandName: product.brandName,
      thumbnailUrl: product.thumbnailUrl,
      price: product.sellingPrice,
      compareAtPrice: product.compareAtPrice,
      quantity: 1,
      availableStock: product.availableStock,
      inStock: product.inStock,
    );

    await ref
        .read(cartControllerProvider.notifier)
        .addToCart(cartItem);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Added to cart!'),
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
      return Container(
        height: 400,
        width: double.infinity,
        color: Colors.grey[200],
        child: const Icon(Icons.image_outlined,
            size: 64, color: Colors.grey),
      );
    }

    return SizedBox(
      height: 400,
      child: PageView.builder(
        itemCount: product.images.length,
        itemBuilder: (context, index) {
          final image = product.images[index];
          return Image.network(
            image.url,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                child: const Icon(Icons.image_not_supported,
                    size: 64),
              );
            },
          );
        },
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VariantChip extends StatelessWidget {
  final variant;

  const _VariantChip({required this.variant});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(variant.displayName),
      backgroundColor: variant.inStock
          ? Colors.blue.shade50
          : Colors.grey.shade200,
      side: BorderSide(
        color: variant.inStock
            ? Colors.blue.shade200
            : Colors.grey.shade400,
      ),
    );
  }
}
