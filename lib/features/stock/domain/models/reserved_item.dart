import 'package:freezed_annotation/freezed_annotation.dart';

part 'reserved_item.freezed.dart';
part 'reserved_item.g.dart';

@freezed
class ReservedItem with _$ReservedItem {
  const factory ReservedItem({
    required String productId,
    required int quantity,
  }) = _ReservedItem;

  factory ReservedItem.fromJson(Map<String, dynamic> json) =>
      _$ReservedItemFromJson(json);
}
