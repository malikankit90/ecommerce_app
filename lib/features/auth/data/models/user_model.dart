import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

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
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String id,
    required String email,
    required String firstName,
    required String lastName,

    String? phoneNumber,
    String? profileImageUrl,

    @Default('active') String accountStatus,
    @Default(false) bool emailVerified,
    @Default(false) bool phoneVerified,

    @Default('customer') String role,
    @Default(<String>[]) List<String> permissions,
    String? fcmToken,

    String? preferredLanguage,
    String? preferredCurrency,
    @Default(true) bool marketingEmailsEnabled,
    @Default(true) bool pushNotificationsEnabled,

    // 🔑 ALL TIMESTAMPS MUST BE NULLABLE
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @TimestampConverter() DateTime? lastLoginAt,
    @TimestampConverter() DateTime? deletedAt,
    @TimestampConverter() DateTime? lastOrderDate,

    String? createdBy,
    String? updatedBy,
    @Default(false) bool isDeleted,

    @Default(0) int totalOrders,
    @Default(0.0) double lifetimeValue,
    @Default(<String>[]) List<String> searchHistory,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    if (data == null) return throw Exception('User doc is null');

    return UserModel.fromJson({...data, 'id': doc.id});
  }

  factory UserModel.fromFirebaseUser({
    required String uid,
    required String email,
    required String firstName,
    required String lastName,
  }) {
    return UserModel(
      id: uid,
      email: email,
      firstName: firstName,
      lastName: lastName,
    );
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');

    json['createdAt'] ??= FieldValue.serverTimestamp();
    json['updatedAt'] ??= FieldValue.serverTimestamp();

    return json;
  }

  String get fullName => '$firstName $lastName';
}
