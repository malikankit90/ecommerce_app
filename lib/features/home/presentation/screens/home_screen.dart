import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../products/presentation/providers/product_providers.dart';
import '../../../categories/presentation/providers/category_providers.dart';
import '../../../cart/presentation/providers/cart_providers.dart';
import '../../../wishlist/presentation/providers/wishlist_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        body: Center(
          child: Text('Auth error: $error'),
        ),
      ),
      data: (user) {
        // 🚨 CRITICAL GUARD
        if (user == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 🔒 Firestore is accessed ONLY after auth is ready
        final userDataAsync = ref.watch(currentUserDataProvider);

        return Scaffold(
          appBar: AppBar(
            title: const Text('ECommerce'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  context.push('/search');
                },
              ),

              /// ❤️ WISHLIST WITH BADGE
              Consumer(
                builder: (context, ref, _) {
                  final wishlistCount =
                      ref.watch(wishlistItemCountProvider);

                  return Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {
                          context.push('/wishlist');
                        },
                      ),
                      if (wishlistCount > 0)
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '$wishlistCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),

              /// 🛒 CART WITH BADGE
              Consumer(
                builder: (context, ref, _) {
                  final cartCount =
                      ref.watch(cartItemCountProvider);

                  return Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_cart_outlined),
                        onPressed: () {
                          context.push('/cart');
                        },
                      ),
                      if (cartCount > 0)
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '$cartCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),

              PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'logout') {
                    await ref
                        .read(authControllerProvider.notifier)
                        .signOut();
                  } else if (value == 'orders') {
                    context.push('/orders');
                  } else if (value == 'addresses') {
                    context.push('/addresses');
                  } else if (value == 'wishlist') {
                    context.push('/wishlist');
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 'orders',
                    child: ListTile(
                      leading: Icon(Icons.shopping_bag),
                      title: Text('My Orders'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'addresses',
                    child: ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text('Addresses'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'wishlist',
                    child: ListTile(
                      leading: Icon(Icons.favorite),
                      title: Text('Wishlist'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'logout',
                    child: ListTile(
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: Text(
                        'Logout',
                        style: TextStyle(color: Colors.red),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ],
          ),

          body: userDataAsync.when(
            loading: () =>
                const Center(child: CircularProgressIndicator()),
            error: (error, _) => const Center(
              child: Text(
                'Failed to load user data',
                style: TextStyle(color: Colors.red),
              ),
            ),
            data: (userData) {
              if (userData == null) {
                return const Center(
                  child: Text('User data not found'),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(currentUserDataProvider);
                  ref.invalidate(featuredProductsProvider);
                  ref.invalidate(newArrivalsProvider);
                  ref.invalidate(featuredCategoriesProvider);
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildWelcome(userData.firstName),
                      _buildCategories(ref, context),
                      _buildFeaturedProducts(ref, context),
                      _buildNewArrivals(ref, context),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // --------------------------------------------------
  Widget _buildWelcome(String name) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade400,
            Colors.blue.shade600,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, $name! 👋',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Welcome to your shopping experience',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories(WidgetRef ref, BuildContext context) {
    final categoriesAsync =
        ref.watch(featuredCategoriesProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.push('/products');
                },
                child: const Text('See All'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          categoriesAsync.when(
            loading: () => const SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, _) => const SizedBox(
              height: 100,
              child: Center(
                child: Text('Failed to load categories'),
              ),
            ),
            data: (categories) {
              if (categories.isEmpty) {
                return SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      _CategoryCard('Men', Icons.male, Colors.blue),
                      _CategoryCard('Women', Icons.female, Colors.pink),
                      _CategoryCard('Kids', Icons.child_care, Colors.orange),
                      _CategoryCard(
                          'Accessories', Icons.watch, Colors.purple),
                    ],
                  ),
                );
              }

              return SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return GestureDetector(
                      onTap: () {
                        context.push(
                          '/products/category/${category.id}',
                          extra: category.name,
                        );
                      },
                      child: _CategoryCard(
                        category.name,
                        Icons.category,
                        Colors.primaries[
                            index % Colors.primaries.length],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProducts(
      WidgetRef ref, BuildContext context) {
    final productsAsync =
        ref.watch(featuredProductsProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Featured Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.push('/products');
                },
                child: const Text('See All'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          productsAsync.when(
            loading: () => const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, _) => const SizedBox(
              height: 200,
              child: Center(
                child: Text('Failed to load products'),
              ),
            ),
            data: (products) {
              if (products.isEmpty) {
                return const SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(
                      'No featured products yet',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              }

              return SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        context.push('/products/${product.id}');
                      },
                      child: _ProductCard(product: product),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNewArrivals(
      WidgetRef ref, BuildContext context) {
    final productsAsync =
        ref.watch(newArrivalsProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'New Arrivals',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.push('/products');
                },
                child: const Text('See All'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          productsAsync.when(
            loading: () => const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, _) => const SizedBox(
              height: 200,
              child: Center(
                child: Text('Failed to load products'),
              ),
            ),
            data: (products) {
              if (products.isEmpty) {
                return const SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(
                      'No new arrivals yet',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              }

              return SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        context.push('/products/${product.id}');
                      },
                      child: _ProductCard(product: product),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _CategoryCard(this.title, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// PRODUCT CARD
// --------------------------------------------------
class _ProductCard extends StatelessWidget {
  final product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              color: Colors.grey[200],
              child: product.thumbnailUrl.isNotEmpty
                  ? Image.network(
                      product.thumbnailUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image_not_supported);
                      },
                    )
                  : const Icon(Icons.image_outlined),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.displayPrice,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
