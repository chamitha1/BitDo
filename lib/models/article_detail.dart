import 'package:json_annotation/json_annotation.dart';

part 'article_detail.g.dart';

@JsonSerializable()
class ArticleDetail {
  ArticleDetail();

  late String id;
  late String pic;
  late String title;
  late String articleId;
  late String contentType;
  late String content;
  late num createDatetime;
  late String contentTypeName;
  
  factory ArticleDetail.fromJson(Map<String,dynamic> json) => _$ArticleDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleDetailToJson(this);
}
