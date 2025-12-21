import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/home_controller.dart';
import '../providers/home_ui_state_provider.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/search_bar.dart';
import '../widgets/top_categories_row.dart';
import '../widgets/subcategories_row.dart';
import '../widgets/trending_products_carousel.dart';
import '../widgets/recommended_products_grid.dart';
import '../../../categories/data/models/category_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeAsync = ref.watch(homeControllerProvider);
    final selectedRootId = ref.watch(selectedRootCategoryIdProvider);

    return Scaffold(
      appBar: const HomeAppBar(),
      body: homeAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('Failed to load home')),
        data: (state) {
          debugPrint('Selected root ID: $selectedRootId');
          debugPrint(
            'Subcats count: ${selectedRootId == null ? 0 : state.subCategoriesOf(selectedRootId).length}',
          );

          // 🔹 Get subcategories ONLY for selected root
          final List<CategoryModel> subCategories = selectedRootId == null
              ? []
              : state.subCategoriesOf(selectedRootId);

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(homeControllerProvider.notifier).refresh(),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                /// SEARCH
                const SliverToBoxAdapter(
                  child: HomeSearchBar(),
                ),

                /// TOP-LEVEL CATEGORIES (Men / Women)
                SliverToBoxAdapter(
                  child: TopCategoriesRow(
                    categories: state.rootCategories,
                  ),
                ),

                /// DYNAMIC SUBCATEGORIES (appears on selection)
                SliverToBoxAdapter(
                  child: SubCategoriesRow(
                    subCategories: subCategories,
                  ),
                ),

                /// TRENDING PRODUCTS
                SliverToBoxAdapter(
                  child: TrendingProductsCarousel(
                    products: state.trending,
                  ),
                ),

                /// RECOMMENDED PRODUCTS
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
          );
        },
      ),
    );
  }
}
