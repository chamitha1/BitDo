// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dict.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dict _$DictFromJson(Map<String, dynamic> json) => Dict(
  key: json['key'] as String,
  value: json['value'] as String,
  parentKey: json['parentKey'] as String?,
  type: json['type'] as String?,
);

Map<String, dynamic> _$DictToJson(Dict instance) => <String, dynamic>{
  'key': instance.key,
  'value': instance.value,
  'parentKey': instance.parentKey,
  'type': instance.type,
};
