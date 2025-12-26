import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/product_model.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../cart/presentation/providers/cart_providers.dart';
import '../../../wishlist/presentation/providers/wishlist_providers.dart';
import '../../../cart/data/models/cart_item_model.dart';
import '../../../wishlist/data/models/wishlist_item_model.dart';

enum ProductCardVariant {
  compact,
  catalog,
  detailed,
}

class ProductCard extends ConsumerWidget {
  final ProductModel product;
  final ProductCardVariant variant;

  const ProductCard({
    super.key,
    required this.product,
    required this.variant,
  });

  double get _height {
    switch (variant) {
      case ProductCardVariant.compact:
        return 240;
      case ProductCardVariant.catalog:
        return 300;
      case ProductCardVariant.detailed:
        return 320;
    }
  }

  double get _imageHeight {
    switch (variant) {
      case ProductCardVariant.compact:
        return 120;
      default:
        return 150;
    }
  }

  int get _titleMaxLines => variant == ProductCardVariant.compact ? 2 : 3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value;

    return SizedBox(
      height: _height,
      width: variant == ProductCardVariant.compact ? 180 : double.infinity,
      child: InkWell(
        onTap: () => context.push('/products/${product.id}'),
        child: Card(
          elevation: 2,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              _ImageSection(product: product, height: _imageHeight),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Badges(product: product),
                      const SizedBox(height: 4),
                      Text(
                        product.brandName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        product.name,
                        maxLines: _titleMaxLines,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      _PriceRow(product: product),
                    ],
                  ),
                ),
              ),
              _ActionsRow(
                product: product,
                userId: user?.uid,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ---------------- IMAGE ---------------- */

class _ImageSection extends StatelessWidget {
  final ProductModel product;
  final double height;

  const _ImageSection({
    required this.product,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          product.thumbnailUrl.isNotEmpty
              ? Image.network(product.thumbnailUrl, fit: BoxFit.cover)
              : Container(
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported),
                ),
          if (!product.inStock)
            Container(
              color: Colors.black54,
              alignment: Alignment.center,
              child: const Text(
                'OUT OF STOCK',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/* ---------------- BADGES ---------------- */

class _Badges extends StatelessWidget {
  final ProductModel product;

  const _Badges({required this.product});

  @override
  Widget build(BuildContext context) {
    if (!product.isTrending && !product.isNewArrival) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 4,
      children: [
        if (product.isTrending) const _Badge('TRENDING', Colors.deepOrange),
        if (product.isNewArrival) const _Badge('NEW', Colors.green),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;

  const _Badge(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

/* ---------------- PRICE ---------------- */

class _PriceRow extends StatelessWidget {
  final ProductModel product;

  const _PriceRow({required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          product.displayPrice,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        if (product.hasDiscount) ...[
          const SizedBox(width: 6),
          Text(
            product.originalPrice,
            style: const TextStyle(
              fontSize: 12,
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
            ),
          ),
        ],
      ],
    );
  }
}

/* ---------------- ACTIONS ---------------- */

class _ActionsRow extends ConsumerWidget {
  final ProductModel product;
  final String? userId;

  const _ActionsRow({
    required this.product,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: (userId == null || !product.inStock)
                  ? null
                  : () {
                      ref.read(cartControllerProvider.notifier).addToCart(
                            CartItemModel(
                              id: '${userId!}_${product.id}_${DateTime.now().millisecondsSinceEpoch}',
                              userId: userId!,
                              productId: product.id,
                              productName: product.name,
                              productSlug: product.slug,
                              brandName: product.brandName,
                              thumbnailUrl: product.thumbnailUrl,
                              price: product.sellingPrice,
                              compareAtPrice: product.compareAtPrice,
                              quantity: 1,
                            ),
                          );
                    },
              child: const Text('Add', style: TextStyle(fontSize: 12)),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: userId == null
                ? null
                : () {
                    ref
                        .read(wishlistControllerProvider.notifier)
                        .toggleWishlist(
                          product.id,
                          WishlistItemModel(
                            id: product.id,
                            userId: userId!,
                            productId: product.id,
                            productName: product.name,
                            productSlug: product.slug,
                            brandName: product.brandName,
                            thumbnailUrl: product.thumbnailUrl,
                            price: product.sellingPrice,
                            compareAtPrice: product.compareAtPrice,
                            inStock: product.inStock,
                            addedAt: DateTime.now(),
                          ),
                        );
                  },
          ),
        ],
      ),
    );
  }
}
