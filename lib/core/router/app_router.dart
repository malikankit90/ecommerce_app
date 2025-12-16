// lib/core/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';

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
import '../../features/auth/presentation/screens/forgot_password_screen.dart';


final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,

    // =============================
    // AUTH REDIRECT LOGIC
    // =============================
    redirect: (context, state) {
      final isLoggedIn = authState.value != null;
      final isAuthRoute =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup' ||
          state.matchedLocation == '/forgot-password';

      if (!isLoggedIn && !isAuthRoute) {
        return '/login';
      }

      if (isLoggedIn && isAuthRoute) {
        return '/';
      }

      return null;
    },

    // =============================
    // ROUTES
    // =============================
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),

      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),

      GoRoute(
        path: '/forgot-password',
        name: 'forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // =============================
      // PRODUCTS (✅ QUERY PARAM BASED)
      // =============================
      GoRoute(
        path: '/products',
        name: 'products',
        builder: (context, state) {
          final categoryId =
              state.uri.queryParameters['categoryId'];
          final title =
              state.uri.queryParameters['title'];

          return ProductsListScreen(
            categoryId: categoryId,
            title: title,
          );
        },
      ),

      GoRoute(
        path: '/products/:id',
        name: 'productDetail',
        builder: (context, state) {
          final productId = state.pathParameters['id']!;
          return ProductDetailScreen(productId: productId);
        },
      ),

      // =============================
      // SEARCH
      // =============================
      GoRoute(
        path: '/search',
        name: 'search',
        builder: (context, state) => const SearchScreen(),
      ),

      // =============================
      // CART
      // =============================
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const CartScreen(),
      ),

      // =============================
      // CHECKOUT
      // =============================
      GoRoute(
        path: '/checkout',
        name: 'checkout',
        builder: (context, state) => const CheckoutScreen(),
      ),

      // =============================
      // ORDERS
      // =============================
      GoRoute(
        path: '/orders',
        name: 'orders',
        builder: (context, state) => const OrdersListScreen(),
      ),

      GoRoute(
        path: '/orders/:id',
        name: 'orderDetail',
        builder: (context, state) {
          final orderId = state.pathParameters['id']!;
          return OrderDetailScreen(orderId: orderId);
        },
      ),

      GoRoute(
        path: '/orders/:id/success',
        name: 'orderSuccess',
        builder: (context, state) {
          final orderId = state.pathParameters['id']!;
          return OrderSuccessScreen(orderId: orderId);
        },
      ),

      // =============================
      // ADDRESSES
      // =============================
      GoRoute(
        path: '/addresses',
        name: 'addresses',
        builder: (context, state) => const AddressesListScreen(),
      ),

      GoRoute(
        path: '/addresses/add',
        name: 'addAddress',
        builder: (context, state) => const AddEditAddressScreen(),
      ),

      GoRoute(
        path: '/addresses/edit/:id',
        name: 'editAddress',
        builder: (context, state) {
          final address = state.extra;
          return AddEditAddressScreen(address: address as dynamic);
        },
      ),

      // =============================
      // WISHLIST
      // =============================
      GoRoute(
        path: '/wishlist',
        name: 'wishlist',
        builder: (context, state) => const WishlistScreen(),
      ),
    ],

    // =============================
    // ERROR PAGE
    // =============================
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline,
                size: 48, color: Colors.red),
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
