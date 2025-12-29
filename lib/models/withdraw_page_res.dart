import 'package:json_annotation/json_annotation.dart';

part 'withdraw_page_res.g.dart';

@JsonSerializable()
class WithdrawPageRes {
  final String id;
  final String userId;
  final String amount;
  final String actualAmount;
  final String fee;
  final String currency;
  final String status;
  final String createDatetime;
  final String? payDatetime;
  final String? applyDatetime;
  final String? payCardNo;
  final String? payCardName;
  final String? payBank;

  WithdrawPageRes({
    required this.id,
    required this.userId,
    required this.amount,
    required this.actualAmount,
    required this.fee,
    required this.currency,
    required this.status,
    required this.createDatetime,
    this.payDatetime,
    this.applyDatetime,
    this.payCardNo,
    this.payCardName,
    this.payBank,
  });

  factory WithdrawPageRes.fromJson(Map<String, dynamic> json) =>
      _$WithdrawPageResFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawPageResToJson(this);
}
