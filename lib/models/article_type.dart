import 'package:json_annotation/json_annotation.dart';
import "article.dart";
part 'article_type.g.dart';

@JsonSerializable()
class ArticleType {
  ArticleType();

  late String id;
  late String name;
  String? icon;
  String? iconDark;
  late String type;
  late String status;
  num? orderNo;
  late String updater;
  late String updaterName;
  late num updateDatetime;
  late String location;
  late List<Article> articleList;

  factory ArticleType.fromJson(Map<String, dynamic> json) =>
      _$ArticleTypeFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleTypeToJson(this);
}
