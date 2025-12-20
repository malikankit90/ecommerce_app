import 'package:flutter/material.dart';
import '../../../products/data/models/product_model.dart';
import '../../../products/presentation/widgets/product_card.dart';

class RecommendedProductsGrid extends StatelessWidget {
  final List<ProductModel> products;

  const RecommendedProductsGrid({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const SliverToBoxAdapter(
        child: SizedBox.shrink(),
      );
    }

    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ProductCard(
            product: products[index],
            variant: ProductCardVariant.catalog,
          );
        },
        childCount: products.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        mainAxisExtent: 320,
      ),
    );
  }
}
