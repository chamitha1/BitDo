import 'package:json_annotation/json_annotation.dart';
import "article_detail.dart";
part 'article.g.dart';

@JsonSerializable()
class Article {
  Article();

  late String id;
  late String typeId;
  late String type;
  late String title;
  late String contentType;
  String? content;
  late String status;
  late num orderNo;
  late String updater;
  late String updaterName;
  late num updateDatetime;
  List<ArticleDetail>? articleDetailList;
  
  factory Article.fromJson(Map<String,dynamic> json) => _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
