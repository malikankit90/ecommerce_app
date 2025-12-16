// lib/features/home/presentation/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/home_controller.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/search_bar.dart';
import '../widgets/top_categories_row.dart';
import '../widgets/horizontal_products_section.dart';
import '../widgets/categories_section.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeAsync = ref.watch(homeControllerProvider);

    return Scaffold(
      appBar: HomeAppBar(), // ❌ const removed
      body: homeAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (_, __) =>
            const Center(child: Text('Failed to load home')),
        data: (state) => RefreshIndicator(
          onRefresh: () =>
              ref.read(homeControllerProvider.notifier).refresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                HomeSearchBar(), // ❌ const removed
                TopCategoriesRow(categories: state.categories),
                HorizontalProductsSection(
                  title: 'Trending Now',
                  products: state.trending,
                ),
                CategoriesSection(categories: state.categories),
                HorizontalProductsSection(
                  title: 'Recommended for You',
                  products: state.recommended,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
