import 'package:flutter/material.dart';
import '../../../products/data/models/product_model.dart';
import '../../../products/presentation/widgets/product_card.dart';
import 'section_header.dart';

class TrendingProductsCarousel extends StatelessWidget {
  final List<ProductModel> products;

  const TrendingProductsCarousel({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Trending Now'),

        SizedBox(
          height: 285,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, index) {
              return ProductCard(
                product: products[index],
                variant: ProductCardVariant.compact, // ✅ CORRECT
              );
            },
          ),
        ),
      ],
    );
  }
}
