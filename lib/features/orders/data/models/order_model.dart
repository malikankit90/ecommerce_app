import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderItemModel with _$OrderItemModel {
  const factory OrderItemModel({
    required String productId,
    required String productName,
    required String productSlug,
    required String brandName,
    required String thumbnailUrl,
    required double price,
    required int quantity,
    String? variantId,
    String? size,
    String? color,
  }) = _OrderItemModel;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);
}

@freezed
class ShippingAddressModel with _$ShippingAddressModel {
  const factory ShippingAddressModel({
    required String fullName,
    required String phoneNumber,
    required String addressLine1,
    String? addressLine2,
    required String city,
    required String state,
    required String postalCode,
    required String country,
  }) = _ShippingAddressModel;

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressModelFromJson(json);
}

@freezed
class OrderModel with _$OrderModel {
  const OrderModel._(); // 👈 required for custom getters

  const factory OrderModel({
    required String id,
    required String userId,
    required String orderNumber,

    // Items
    required List<OrderItemModel> items,
    required int totalItems,

    // Pricing
    required double subtotal,
    required double discount,
    required double shippingCost,
    required double tax,
    required double total,

    // Shipping
    required ShippingAddressModel shippingAddress,

    // Payment
    required String paymentMethod,
    @Default('pending') String paymentStatus, // pending, paid, failed, refunded

    // Status
    @Default('pending')
    String status, // pending, confirmed, processing, shipped, delivered, cancelled

    // Tracking
    String? trackingNumber,
    String? carrier,

    // Timestamps (DOMAIN only – Firestore sets them)
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? confirmedAt,
    DateTime? shippedAt,
    DateTime? deliveredAt,
    DateTime? cancelledAt,
    int? createdAtMillis,

    // Notes
    String? customerNote,
    String? adminNote,

    @Default(false) bool isDeleted,
  }) = _OrderModel;

  /// ===============================
  /// Firestore → Domain mapping
  /// ===============================
  factory OrderModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    if (data == null) throw Exception('Order document is null');

    return OrderModel(
      id: doc.id,
      userId: data['userId'],
      orderNumber: data['orderNumber'],
      items: (data['items'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
      totalItems: data['totalItems'],
      subtotal: (data['subtotal'] as num).toDouble(),
      discount: (data['discount'] as num).toDouble(),
      shippingCost: (data['shippingCost'] as num).toDouble(),
      tax: (data['tax'] as num).toDouble(),
      total: (data['total'] as num).toDouble(),
      shippingAddress:
          ShippingAddressModel.fromJson(data['shippingAddress']),
      paymentMethod: data['paymentMethod'],
      paymentStatus: data['paymentStatus'],
      status: data['status'],
      trackingNumber: data['trackingNumber'],
      carrier: data['carrier'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
      confirmedAt: (data['confirmedAt'] as Timestamp?)?.toDate(),
      shippedAt: (data['shippedAt'] as Timestamp?)?.toDate(),
      deliveredAt: (data['deliveredAt'] as Timestamp?)?.toDate(),
      cancelledAt: (data['cancelledAt'] as Timestamp?)?.toDate(),
      createdAtMillis: data['createdAtMillis'] as int?,
      customerNote: data['customerNote'],
      adminNote: data['adminNote'],
      isDeleted: data['isDeleted'] ?? false,
    );
  }

  /// ===============================
  /// DOMAIN / UI HELPERS
  /// ===============================

  String get statusDisplay {
    switch (status) {
      case 'pending':
        return 'Pending';
      case 'confirmed':
        return 'Confirmed';
      case 'processing':
        return 'Processing';
      case 'shipped':
        return 'Shipped';
      case 'delivered':
        return 'Delivered';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  bool get canCancel =>
      status == 'pending' || status == 'confirmed';

  bool get isActive =>
      status != 'delivered' && status != 'cancelled';
}
