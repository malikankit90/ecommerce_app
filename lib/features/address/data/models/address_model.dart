import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'address_model.freezed.dart';
part 'address_model.g.dart';

/// =======================================================
/// Timestamp Converter (FIRESTORE ONLY)
/// =======================================================
///
/// ⚠️ DO NOT use this JSON for Cloud Functions
/// =======================================================

class TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json == null) return null;
    if (json is Timestamp) return json.toDate();
    if (json is DateTime) return json;
    throw Exception('Invalid timestamp value: $json');
  }

  @override
  Object? toJson(DateTime? date) {
    if (date == null) return null;
    return Timestamp.fromDate(date);
  }
}

@freezed
class AddressModel with _$AddressModel {
  const AddressModel._();

  const factory AddressModel({
    required String id,
    required String userId,
    required String fullName,
    required String phoneNumber,
    required String addressLine1,
    String? addressLine2,
    required String city,
    required String state,
    required String postalCode,
    required String country,
    @Default('home') String type, // home, work, other
    @Default(false) bool isDefault,
    String? label,
    String? instructions,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @Default(false) bool isDeleted,
  }) = _AddressModel;

  // =====================================================
  // FACTORIES
  // =====================================================

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  factory AddressModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    if (data == null) {
      throw Exception('Address document is null');
    }
    return AddressModel.fromJson({
      ...data,
      'id': doc.id,
    });
  }

  // =====================================================
  // FIRESTORE SERIALIZATION
  // =====================================================
  /// ✅ USE THIS FOR FIRESTORE ONLY
  /// ❌ NEVER send this to Cloud Functions
  // =====================================================

  Map<String, dynamic> toFirestore() {
    final json = toJson();

    json.remove('id');

    json['createdAt'] ??= FieldValue.serverTimestamp();
    json['updatedAt'] ??= FieldValue.serverTimestamp();

    return json;
  }

  // =====================================================
  // CLOUD FUNCTION SERIALIZATION (CRITICAL)
  // =====================================================
  /// ✅ SAFE for httpsCallable
  /// ❌ No Timestamp
  /// ❌ No FieldValue
  /// ❌ No DateTime
  // =====================================================

  Map<String, dynamic> toCallableJson() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'type': type,
      'label': label,
      'instructions': instructions,
    };
  }

  // =====================================================
  // UI HELPERS
  // =====================================================

  String get fullAddress {
    final parts = [
      addressLine1,
      if (addressLine2 != null && addressLine2!.isNotEmpty) addressLine2,
      city,
      state,
      postalCode,
      country,
    ];
    return parts.join(', ');
  }

  String get shortAddress => '$addressLine1, $city';
}
