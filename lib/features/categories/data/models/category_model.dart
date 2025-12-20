import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

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
class CategoryModel with _$CategoryModel {
  const CategoryModel._();

  const factory CategoryModel({
    required String id,
    required String name,
    required String slug,
    required String description,
    required String imageUrl,

    String? iconUrl,
    String? bannerUrl,

    /// 🔑 HIERARCHY
    String? parentCategoryId,
    @Default(0) int level,
    @Default(0) int sortOrder,

    /// STATUS
    @Default(true) bool isActive,
    @Default(false) bool isFeatured,
    @Default(false) bool isDeleted,

    /// STATS
    @Default(0) int productCount,

    /// TIMESTAMPS
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  factory CategoryModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    if (data == null) throw Exception('Category document is null');
    return CategoryModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    json['createdAt'] ??= FieldValue.serverTimestamp();
    json['updatedAt'] ??= FieldValue.serverTimestamp();
    return json;
  }

  /// HELPERS
  bool get isRoot => parentCategoryId == null && level == 0;
  bool get isAvailable => isActive && !isDeleted;
}
