import 'package:json_annotation/json_annotation.dart';
import "ads_home_res.dart";
part 'ads_my_page_res.g.dart';

@JsonSerializable()
class AdsMyPageRes {
  AdsMyPageRes();

  late String id;
  late String nickname;
  late String photo;
  late String tradeType;
  late String tradeCurrency;
  late String tradeCoin;
  late String premiumRate;
  late String truePrice;
  late String minTrade;
  late String maxTrade;
  late String payType;
  late String userId;
  late String leftCount;
  late String status;
  String? bankName;
  String? bankPic;
  late AdsHomeRes userStatistics;

  factory AdsMyPageRes.fromJson(Map<String, dynamic> json) =>
      _$AdsMyPageResFromJson(json);
  Map<String, dynamic> toJson() => _$AdsMyPageResToJson(this);
}
