import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../cart/presentation/providers/cart_providers.dart';
import '../../../address/presentation/providers/address_providers.dart';
import '../../../address/data/models/address_model.dart';
import '../../../orders/data/models/order_model.dart';
import '../../../orders/presentation/providers/order_providers.dart';
import 'package:ecommerce_app/features/auth/presentation/providers/auth_providers.dart';

final selectedAddressProvider = StateProvider<AddressModel?>((ref) => null);
final selectedPaymentMethodProvider = StateProvider<String>((ref) => 'cod');

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _noteController = TextEditingController();
  bool _isPlacingOrder = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        body: Center(child: Text('Auth error: $error')),
      ),
      data: (user) {
        if (user == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final cartItemsAsync = ref.watch(cartItemsStreamProvider);
        final addressesAsync = ref.watch(addressesStreamProvider);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Checkout'),
          ),
          body: cartItemsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('Error: $error')),
            data: (cartItems) {
              if (cartItems.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Your cart is empty'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => context.go('/'),
                        child: const Text('Continue Shopping'),
                      ),
                    ],
                  ),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Shipping Address Section
                    _buildSectionHeader('Shipping Address'),
                    addressesAsync.when(
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (error, _) => Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text('Error loading addresses: $error'),
                      ),
                      data: (addresses) {
                        if (addresses.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: ElevatedButton(
                              onPressed: () => context.push('/addresses/add'),
                              child: const Text('Add Shipping Address'),
                            ),
                          );
                        }

                        final selectedAddress = ref.watch(selectedAddressProvider);
                        
                        // Auto-select default address
                        if (selectedAddress == null) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            final defaultAddr = addresses.firstWhere(
                              (a) => a.isDefault,
                              orElse: () => addresses.first,
                            );
                            ref.read(selectedAddressProvider.notifier).state = defaultAddr;
                          });
                        }

                        return _buildAddressSelector(addresses, selectedAddress);
                      },
                    ),

                    // Payment Method Section
                    _buildSectionHeader('Payment Method'),
                    _buildPaymentMethodSelector(),

                    // Order Notes
                    _buildSectionHeader('Order Notes (Optional)'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _noteController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Add any special instructions...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),

                    // Order Summary
                    _buildSectionHeader('Order Summary'),
                    _buildOrderSummary(cartItems),

                    const SizedBox(height: 100), // Space for bottom bar
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: _buildBottomBar(context),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAddressSelector(List<AddressModel> addresses, AddressModel? selectedAddress) {
    return Column(
      children: [
        ...addresses.map((address) {
          final isSelected = selectedAddress?.id == address.id;
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            color: isSelected ? Colors.blue.shade50 : null,
            child: RadioListTile<String>(
              value: address.id,
              groupValue: selectedAddress?.id,
              onChanged: (value) {
                ref.read(selectedAddressProvider.notifier).state = address;
              },
              title: Text(
                address.fullName,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(address.phoneNumber),
                  const SizedBox(height: 2),
                  Text(address.shortAddress),
                  if (address.isDefault)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Default',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }).toList(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextButton.icon(
            onPressed: () => context.push('/addresses/add'),
            icon: const Icon(Icons.add),
            label: const Text('Add New Address'),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSelector() {
    final selectedMethod = ref.watch(selectedPaymentMethodProvider);

    return Column(
      children: [
        RadioListTile<String>(
          value: 'cod',
          groupValue: selectedMethod,
          onChanged: (value) {
            ref.read(selectedPaymentMethodProvider.notifier).state = value!;
          },
          title: const Text('Cash on Delivery'),
          subtitle: const Text('Pay when you receive'),
          secondary: const Icon(Icons.money),
        ),
        RadioListTile<String>(
          value: 'card',
          groupValue: selectedMethod,
          onChanged: (value) {
            ref.read(selectedPaymentMethodProvider.notifier).state = value!;
          },
          title: const Text('Credit/Debit Card'),
          subtitle: const Text('Coming soon'),
          secondary: const Icon(Icons.credit_card),
          enabled: false,
        ),
        RadioListTile<String>(
          value: 'upi',
          groupValue: selectedMethod,
          onChanged: (value) {
            ref.read(selectedPaymentMethodProvider.notifier).state = value!;
          },
          title: const Text('UPI'),
          subtitle: const Text('Coming soon'),
          secondary: const Icon(Icons.account_balance),
          enabled: false,
        ),
      ],
    );
  }

  Widget _buildOrderSummary(List cartItems) {
    final totals = ref.watch(cartTotalsProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...cartItems.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${item.productName} x${item.quantity}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Text(
                  '\$${item.subtotal.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          )).toList(),
          const Divider(height: 24),
          _buildSummaryRow('Subtotal', totals['subtotal']!),
          if (totals['savings']! > 0)
            _buildSummaryRow('Savings', -totals['savings']!, isGreen: true),
          _buildSummaryRow('Shipping', 0.0),
          const Divider(height: 24),
          _buildSummaryRow(
            'Total',
            totals['total']!,
            isBold: true,
            isLarge: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    double amount, {
    bool isBold = false,
    bool isLarge = false,
    bool isGreen = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isLarge ? 18 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isGreen ? Colors.green : null,
            ),
          ),
          Text(
            '${amount < 0 ? '-' : ''}\$${amount.abs().toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isLarge ? 18 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              color: isGreen ? Colors.green : (isBold ? Colors.blue : null),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final totals = ref.watch(cartTotalsProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Amount',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    '\$${totals['total']!.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: _isPlacingOrder ? null : _handlePlaceOrder,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isPlacingOrder
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Place Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handlePlaceOrder() async {
    print('🔵 Place Order button clicked');
    
    final selectedAddress = ref.read(selectedAddressProvider);
    final selectedPaymentMethod = ref.read(selectedPaymentMethodProvider);
    final cartItems = ref.read(cartItemsStreamProvider).value;
    final totals = ref.read(cartTotalsProvider);
    final authState = ref.read(authStateProvider).value;

    print('🔵 Selected address: ${selectedAddress?.id}');
    print('🔵 Cart items count: ${cartItems?.length}');
    print('🔵 Auth state: ${authState?.uid}');

    if (selectedAddress == null) {
      print('❌ No address selected');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a shipping address'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    if (cartItems == null || cartItems.isEmpty) {
      print('❌ Cart is empty');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Your cart is empty'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    if (authState == null) {
      print('❌ User not authenticated');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please login to continue'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    setState(() => _isPlacingOrder = true);
    print('🔵 Setting loading state to true');

    try {
      print('🔵 Generating order number...');
      // Generate order number
      final orderNumber = await ref
          .read(orderControllerProvider.notifier)
          .generateOrderNumber();
      print('✅ Order number generated: $orderNumber');

      print('🔵 Creating order object...');
      // Create order
      final order = OrderModel(
        id: '${authState.uid}_${DateTime.now().millisecondsSinceEpoch}',
        userId: authState.uid,
        orderNumber: orderNumber,
        items: cartItems.map((item) => OrderItemModel(
          productId: item.productId,
          productName: item.productName,
          productSlug: item.productSlug,
          brandName: item.brandName,
          thumbnailUrl: item.thumbnailUrl,
          price: item.price,
          quantity: item.quantity,
          variantId: item.variantId,
          size: item.size,
          color: item.color,
        )).toList(),
        totalItems: cartItems.length,
        subtotal: totals['subtotal']!,
        discount: totals['savings']!,
        shippingCost: 0.0,
        tax: 0.0,
        total: totals['total']!,
        shippingAddress: ShippingAddressModel(
          fullName: selectedAddress.fullName,
          phoneNumber: selectedAddress.phoneNumber,
          addressLine1: selectedAddress.addressLine1,
          addressLine2: selectedAddress.addressLine2,
          city: selectedAddress.city,
          state: selectedAddress.state,
          postalCode: selectedAddress.postalCode,
          country: selectedAddress.country,
        ),
        paymentMethod: selectedPaymentMethod,
        paymentStatus: 'pending',
        status: 'pending',
        customerNote: _noteController.text.trim().isEmpty 
            ? null 
            : _noteController.text.trim(),
      );
      print('✅ Order object created: ${order.id}');

      print('🔵 Placing order...');
      // Place order
      final orderId = await ref
          .read(orderControllerProvider.notifier)
          .createOrder(order);
      print('✅ Order placed with ID: $orderId');

      if (orderId != null) {
        print('🔵 Clearing cart...');
        // Clear cart
        await ref.read(cartControllerProvider.notifier).clearCart();
        print('✅ Cart cleared');

        if (mounted) {
          print('🔵 Navigating to success screen...');
          // Navigate to order confirmation
          context.go('/orders/$orderId/success');
          print('✅ Navigation complete');
        }
      } else {
        print('❌ Order ID is null after creation');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to create order. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e, stackTrace) {
      print('❌ ERROR placing order: $e');
      print('❌ Stack trace: $stackTrace');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to place order: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } finally {
      if (mounted) {
        print('🔵 Resetting loading state');
        setState(() => _isPlacingOrder = false);
      }
    }
  }
} 