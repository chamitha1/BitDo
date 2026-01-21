import 'package:json_annotation/json_annotation.dart';

part 'ads_detail_res.g.dart';

@JsonSerializable()
class AdsDetailRes {
  final String? id;
  final String? tradeType;
  final String? tradeCurrency;
  final String? tradeCoin;
  final String? premiumRate;
  final String? totalCount;
  final String? leftCount;
  final String? protectPrice;
  final String? truePrice;
  final String? minTrade;
  final String? maxTrade;
  final String? payType;
  final String? bankcardId;
  final String? bankName;
  final String? bankPic;
  final String? leaveMessage;
  final String? icon;
  final String? count;
  final String? tradeAmount;
  final String? countMax;
  final String? tradeAmountMax;
  final String? userId;
  final String? nickname;
  final String? photo;
  final String? realName;
  final String? subbranch;

  AdsDetailRes({
    this.id,
    this.tradeType,
    this.tradeCurrency,
    this.tradeCoin,
    this.premiumRate,
    this.totalCount,
    this.leftCount,
    this.protectPrice,
    this.truePrice,
    this.minTrade,
    this.maxTrade,
    this.payType,
    this.bankcardId,
    this.bankName,
    this.bankPic,
    this.leaveMessage,
    this.icon,
    this.count,
    this.tradeAmount,
    this.countMax,
    this.tradeAmountMax,
    this.userId,
    this.nickname,
    this.photo,
    this.realName,
    this.subbranch,
  });

  factory AdsDetailRes.fromJson(Map<String, dynamic> json) =>
      _$AdsDetailResFromJson(json);

  Map<String, dynamic> toJson() => _$AdsDetailResToJson(this);
}
