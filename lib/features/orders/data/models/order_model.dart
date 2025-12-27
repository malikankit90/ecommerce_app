import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

/// =======================================================
/// ORDER ITEM
/// =======================================================

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

/// =======================================================
/// SHIPPING ADDRESS
/// =======================================================

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

/// =======================================================
/// ORDER MODEL (STOCK-SAFE + IDEMPOTENT)
/// =======================================================

@freezed
class OrderModel with _$OrderModel {
  const OrderModel._();

  const factory OrderModel({
    /// 🔑 Firestore document ID
    required String id,

    /// 🔑 Auth UID
    required String userId,

    /// 🔁 Client-generated idempotency key
    required String idempotencyKey,

    /// 🔒 Stock reservation IDs (ONE PER ITEM)
    /// Order is INVALID without these
    @Default(<String>[]) List<String> reservationIds,

    /// Human-readable order number
    required String orderNumber,

    // ---------------- ITEMS ----------------
    required List<OrderItemModel> items,
    required int totalItems,

    // ---------------- PRICING ----------------
    required double subtotal,
    required double discount,
    required double shippingCost,
    required double tax,
    required double total,

    // ---------------- SHIPPING ----------------
    required ShippingAddressModel shippingAddress,

    // ---------------- PAYMENT ----------------
    required String paymentMethod,

    /// pending | paid | failed | refunded
    @Default('pending') String paymentStatus,

    // ---------------- ORDER STATE ----------------
    /// payment_pending | confirmed | processing | shipped | delivered | cancelled | failed
    @Default('payment_pending') String status,

    // ---------------- TRACKING ----------------
    String? trackingNumber,
    String? carrier,

    // ---------------- TIMESTAMPS ----------------
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? paidAt,
    DateTime? confirmedAt,
    DateTime? shippedAt,
    DateTime? deliveredAt,
    DateTime? cancelledAt,
    int? createdAtMillis,

    // ---------------- NOTES ----------------
    String? customerNote,
    String? adminNote,
    @Default(false) bool isDeleted,
  }) = _OrderModel;

  /// =====================================================
  /// Firestore → Domain Mapper
  /// =====================================================

  factory OrderModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    if (data == null) {
      throw StateError('Order document is null');
    }

    final reservationIds = List<String>.from(data['reservationIds'] ?? []);

    if (reservationIds.isEmpty) {
      throw StateError(
        'Corrupted order: reservationIds missing for order ${doc.id}',
      );
    }

    return OrderModel(
      id: doc.id,
      userId: data['userId'] as String,
      idempotencyKey: data['idempotencyKey'] as String,
      reservationIds: reservationIds,
      orderNumber: data['orderNumber'] as String,
      items: (data['items'] as List)
          .map(
            (e) => OrderItemModel.fromJson(
              Map<String, dynamic>.from(e),
            ),
          )
          .toList(),
      totalItems: data['totalItems'] as int,
      subtotal: (data['subtotal'] as num).toDouble(),
      discount: (data['discount'] as num).toDouble(),
      shippingCost: (data['shippingCost'] as num).toDouble(),
      tax: (data['tax'] as num).toDouble(),
      total: (data['total'] as num).toDouble(),
      shippingAddress: ShippingAddressModel.fromJson(
        Map<String, dynamic>.from(data['shippingAddress']),
      ),
      paymentMethod: data['paymentMethod'] as String,
      paymentStatus: data['paymentStatus'] ?? 'pending',
      status: data['status'] ?? 'payment_pending',
      trackingNumber: data['trackingNumber'],
      carrier: data['carrier'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
      paidAt: (data['paidAt'] as Timestamp?)?.toDate(),
      confirmedAt: (data['confirmedAt'] as Timestamp?)?.toDate(),
      shippedAt: (data['shippedAt'] as Timestamp?)?.toDate(),
      deliveredAt: (data['deliveredAt'] as Timestamp?)?.toDate(),
      cancelledAt: (data['cancelledAt'] as Timestamp?)?.toDate(),
      createdAtMillis: data['createdAtMillis'],
      customerNote: data['customerNote'],
      adminNote: data['adminNote'],
      isDeleted: data['isDeleted'] ?? false,
    );
  }

  /// =====================================================
  /// DOMAIN HELPERS (SINGLE SOURCE OF TRUTH)
  /// =====================================================

  String get statusDisplay {
    switch (status) {
      case 'payment_pending':
        return 'Awaiting Payment';
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
      case 'failed':
        return 'Failed';
      default:
        return 'Unknown';
    }
  }

  bool get canCancel => status == 'payment_pending' || status == 'confirmed';

  bool get isFinal =>
      status == 'delivered' || status == 'cancelled' || status == 'failed';
}
