import 'package:json_annotation/json_annotation.dart';

part 'withdraw_request.g.dart';

@JsonSerializable()
class WithdrawRequest {
  final String accountNumber;
  final String amount;
  final String payCardNo;
  final String tradePwd;
  final String smsCaptcha;
  final String? googleSecret;
  final String currency;
  final String bizType;
  final String bizCategory;

  WithdrawRequest({
    required this.accountNumber,
    required this.amount,
    required this.payCardNo,
    required this.tradePwd,
    required this.smsCaptcha,
    this.googleSecret,
    required this.currency,
    required this.bizType,
    required this.bizCategory,
  });

  factory WithdrawRequest.fromJson(Map<String, dynamic> json) => _$WithdrawRequestFromJson(json);
  Map<String, dynamic> toJson() => _$WithdrawRequestToJson(this);
}
