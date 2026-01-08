// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleType _$ArticleTypeFromJson(Map<String, dynamic> json) => ArticleType()
  ..id = json['id'] as String
  ..name = json['name'] as String
  ..icon = json['icon'] as String?
  ..iconDark = json['iconDark'] as String?
  ..type = json['type'] as String
  ..status = json['status'] as String
  ..orderNo = json['orderNo'] as num?
  ..updater = json['updater'] as String
  ..updaterName = json['updaterName'] as String
  ..updateDatetime = json['updateDatetime'] as num
  ..location = json['location'] as String
  ..articleList = (json['articleList'] as List<dynamic>)
      .map((e) => Article.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$ArticleTypeToJson(ArticleType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'iconDark': instance.iconDark,
      'type': instance.type,
      'status': instance.status,
      'orderNo': instance.orderNo,
      'updater': instance.updater,
      'updaterName': instance.updaterName,
      'updateDatetime': instance.updateDatetime,
      'location': instance.location,
      'articleList': instance.articleList,
    };
