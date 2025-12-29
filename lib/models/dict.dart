import 'package:json_annotation/json_annotation.dart';

part 'dict.g.dart';

@JsonSerializable()
class Dict {
  final String key;
  final String value;
  final String? parentKey;
  final String? type;

  Dict({
    required this.key,
    required this.value,
    this.parentKey,
    this.type,
  });

  factory Dict.fromJson(Map<String, dynamic> json) => _$DictFromJson(json);

  Map<String, dynamic> toJson() => _$DictToJson(this);
}
