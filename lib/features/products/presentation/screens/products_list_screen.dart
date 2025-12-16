import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/product_providers.dart';
import '../widgets/product_card.dart';
import '../../data/models/product_model.dart';

class ProductsListScreen extends ConsumerWidget {
  final String? categoryId;
  final String? title;

  const ProductsListScreen({
    super.key,
    this.categoryId,
    this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ✅ CORRECT DATA SOURCE SELECTION
    final AsyncValue<List<ProductModel>> productsAsync =
        categoryId == null
            ? ref.watch(productsStreamProvider)
            : ref.watch(productsByCategoryProvider(categoryId!));

    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
        ],
      ),

      body: productsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),

        error: (_, __) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              const Text('Failed to load products'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  if (categoryId == null) {
                    ref.invalidate(productsStreamProvider);
                  } else {
                    ref.invalidate(
                      productsByCategoryProvider(categoryId!),
                    );
                  }
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),

        data: (products) {
          if (products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No products found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              if (categoryId == null) {
                ref.invalidate(productsStreamProvider);
              } else {
                ref.invalidate(
                  productsByCategoryProvider(categoryId!),
                );
              }
            },
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 320,
              ),
              itemCount: products.length,
              itemBuilder: (_, index) {
                return ProductCard(
                  product: products[index],
                  variant: ProductCardVariant.catalog, // ✅ LIST VARIANT
                );
              },
            ),
          );
        },
      ),
    );
  }
}
