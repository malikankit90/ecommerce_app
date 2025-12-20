import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/home_controller.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/search_bar.dart';
import '../widgets/top_categories_row.dart';
import '../widgets/trending_products_carousel.dart';
import '../widgets/category_section_row.dart';
import '../widgets/recommended_products_grid.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeAsync = ref.watch(homeControllerProvider);

    return Scaffold(
      appBar: const HomeAppBar(),
      body: homeAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (_, __) =>
            const Center(child: Text('Failed to load home')),
        data: (state) => RefreshIndicator(
          onRefresh: () =>
              ref.read(homeControllerProvider.notifier).refresh(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(
                child: HomeSearchBar(),
              ),

              SliverToBoxAdapter(
                child: TopCategoriesRow(
                  categories: state.rootCategories,
                ),
              ),

              SliverToBoxAdapter(
                child: TrendingProductsCarousel(
                  products: state.trending,
                ),
              ),

              for (final root in state.rootCategories)
                SliverToBoxAdapter(
                  child: CategorySectionRow(
                    rootCategory: root,
                    subCategories:
                        state.subCategoriesOf(root.id),
                  ),
                ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: RecommendedProductsGrid(
                  products: state.recommended,
                ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
