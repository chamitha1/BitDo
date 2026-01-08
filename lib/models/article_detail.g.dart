// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDetail _$ArticleDetailFromJson(Map<String, dynamic> json) =>
    ArticleDetail()
      ..id = json['id'] as String
      ..pic = json['pic'] as String
      ..title = json['title'] as String
      ..articleId = json['articleId'] as String
      ..contentType = json['contentType'] as String
      ..content = json['content'] as String
      ..createDatetime = json['createDatetime'] as num
      ..contentTypeName = json['contentTypeName'] as String;

Map<String, dynamic> _$ArticleDetailToJson(ArticleDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pic': instance.pic,
      'title': instance.title,
      'articleId': instance.articleId,
      'contentType': instance.contentType,
      'content': instance.content,
      'createDatetime': instance.createDatetime,
      'contentTypeName': instance.contentTypeName,
    };
