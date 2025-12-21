import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';

import '../../features/home/presentation/screens/home_screen.dart';

import '../../features/categories/data/models/category_model.dart';
import '../../features/categories/presentation/screens/category_landing_screen.dart';

import '../../features/products/presentation/screens/products_list_screen.dart';
import '../../features/products/presentation/screens/product_detail_screen.dart';
import '../../features/products/presentation/screens/search_screen.dart';

import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/checkout/presentation/screens/checkout_screen.dart';
import '../../features/checkout/presentation/screens/order_success_screen.dart';

import '../../features/orders/presentation/screens/orders_list_screen.dart';
import '../../features/orders/presentation/screens/order_detail_screen.dart';

import '../../features/address/presentation/screens/addresses_list_screen.dart';
import '../../features/address/presentation/screens/add_edit_address_screen.dart';

import '../../features/wishlist/presentation/screens/wishlist_screen.dart';

import '../widgets/app_bottom_nav_bar.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,

    // =====================================================
    // AUTH + GUEST REDIRECT (FINAL & CORRECT)
    // =====================================================
    redirect: (context, state) {
      final isLoggedIn = authState.value != null;

      final authRoutes = [
        '/login',
        '/signup',
        '/forgot-password',
      ];

      final guestAllowedPrefixes = [
        '/',
        '/category',
        '/products',
        '/search',
      ];

      final isAuthRoute = authRoutes.contains(state.matchedLocation);

      final isGuestAllowed =
          guestAllowedPrefixes.any((p) => state.matchedLocation.startsWith(p));

      // 🚫 Guest accessing protected route
      if (!isLoggedIn && !isAuthRoute && !isGuestAllowed) {
        return '/login';
      }

      // 🚫 Logged-in user accessing auth pages
      if (isLoggedIn && isAuthRoute) {
        return '/';
      }

      return null;
    },

    // =====================================================
    // ROUTES
    // =====================================================
    routes: [
      // =============================
      // AUTH (NO BOTTOM NAV)
      // =============================
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // =============================
      // MAIN APP (WITH BOTTOM NAV)
      // =============================
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            body: child,
            bottomNavigationBar: const AppBottomNavBar(),
          );
        },
        routes: [
          // -------- HOME
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeScreen(),
          ),

          // -------- SEARCH
          GoRoute(
            path: '/search',
            builder: (context, state) => const SearchScreen(),
          ),

          // -------- CATEGORY LANDING
          GoRoute(
            path: '/category',
            builder: (context, state) {
              final category = state.extra as CategoryModel;
              return CategoryLandingScreen(
                rootCategory: category,
              );
            },
          ),

          // -------- PRODUCTS
          GoRoute(
            path: '/products',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;

              return ProductsListScreen(
                categoryId: extra?['categoryId'],
                title: extra?['title'],
              );
            },
          ),

          GoRoute(
            path: '/products/:id',
            builder: (context, state) {
              final productId = state.pathParameters['id']!;
              return ProductDetailScreen(
                productId: productId,
              );
            },
          ),

          // -------- WISHLIST (AUTH)
          GoRoute(
            path: '/wishlist',
            builder: (context, state) => const WishlistScreen(),
          ),

          // -------- CART (AUTH)
          GoRoute(
            path: '/cart',
            builder: (context, state) => const CartScreen(),
          ),

          // -------- CHECKOUT (AUTH)
          GoRoute(
            path: '/checkout',
            builder: (context, state) => const CheckoutScreen(),
          ),

          // -------- ORDERS / PROFILE
          GoRoute(
            path: '/orders',
            builder: (context, state) => const OrdersListScreen(),
          ),

          GoRoute(
            path: '/orders/:id',
            builder: (context, state) {
              final orderId = state.pathParameters['id']!;
              return OrderDetailScreen(
                orderId: orderId,
              );
            },
          ),

          GoRoute(
            path: '/orders/:id/success',
            builder: (context, state) {
              final orderId = state.pathParameters['id']!;
              return OrderSuccessScreen(
                orderId: orderId,
              );
            },
          ),

          // -------- ADDRESSES
          GoRoute(
            path: '/addresses',
            builder: (context, state) => const AddressesListScreen(),
          ),
          GoRoute(
            path: '/addresses/add',
            builder: (context, state) => const AddEditAddressScreen(),
          ),
          GoRoute(
            path: '/addresses/edit/:id',
            builder: (context, state) {
              final address = state.extra;
              return AddEditAddressScreen(
                address: address as dynamic,
              );
            },
          ),
        ],
      ),
    ],

    // =====================================================
    // ERROR PAGE
    // =====================================================
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text('Error: ${state.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});
