// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      accountStatus: json['accountStatus'] as String? ?? 'active',
      emailVerified: json['emailVerified'] as bool? ?? false,
      phoneVerified: json['phoneVerified'] as bool? ?? false,
      role: json['role'] as String? ?? 'customer',
      permissions: (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      fcmToken: json['fcmToken'] as String?,
      preferredLanguage: json['preferredLanguage'] as String?,
      preferredCurrency: json['preferredCurrency'] as String?,
      marketingEmailsEnabled: json['marketingEmailsEnabled'] as bool? ?? true,
      pushNotificationsEnabled:
          json['pushNotificationsEnabled'] as bool? ?? true,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      lastLoginAt: const TimestampConverter().fromJson(json['lastLoginAt']),
      deletedAt: const TimestampConverter().fromJson(json['deletedAt']),
      lastOrderDate: const TimestampConverter().fromJson(json['lastOrderDate']),
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      totalOrders: (json['totalOrders'] as num?)?.toInt() ?? 0,
      lifetimeValue: (json['lifetimeValue'] as num?)?.toDouble() ?? 0.0,
      searchHistory: (json['searchHistory'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'profileImageUrl': instance.profileImageUrl,
      'accountStatus': instance.accountStatus,
      'emailVerified': instance.emailVerified,
      'phoneVerified': instance.phoneVerified,
      'role': instance.role,
      'permissions': instance.permissions,
      'fcmToken': instance.fcmToken,
      'preferredLanguage': instance.preferredLanguage,
      'preferredCurrency': instance.preferredCurrency,
      'marketingEmailsEnabled': instance.marketingEmailsEnabled,
      'pushNotificationsEnabled': instance.pushNotificationsEnabled,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'lastLoginAt': const TimestampConverter().toJson(instance.lastLoginAt),
      'deletedAt': const TimestampConverter().toJson(instance.deletedAt),
      'lastOrderDate':
          const TimestampConverter().toJson(instance.lastOrderDate),
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'isDeleted': instance.isDeleted,
      'totalOrders': instance.totalOrders,
      'lifetimeValue': instance.lifetimeValue,
      'searchHistory': instance.searchHistory,
    };
