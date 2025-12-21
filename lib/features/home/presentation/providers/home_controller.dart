// lib/features/home/presentation/providers/home_controller.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/home_state.dart';
import '../../../products/presentation/providers/product_providers.dart';
import '../../../categories/presentation/providers/category_providers.dart';

final homeControllerProvider = AsyncNotifierProvider<HomeController, HomeState>(
  HomeController.new,
);

class HomeController extends AsyncNotifier<HomeState> {
  @override
  Future<HomeState> build() async {
    final trending = await ref.watch(featuredProductsProvider.future);

    final recommended = await ref.watch(newArrivalsProvider.future);

    // 🔥 FIX: LOAD ALL CATEGORIES (ROOT + SUB)
    final categories = await ref.watch(categoriesStreamProvider.future);

    return HomeState(
      trending: trending,
      recommended: recommended,
      categories: categories,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();

    ref.invalidate(featuredProductsProvider);
    ref.invalidate(newArrivalsProvider);
    ref.invalidate(categoriesStreamProvider);

    state = await AsyncValue.guard(build);
  }
}
