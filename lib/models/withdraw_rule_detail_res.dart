import 'package:json_annotation/json_annotation.dart';

part 'withdraw_rule_detail_res.g.dart';

@JsonSerializable()
class WithdrawRuleDetailRes {
  final String? withdrawRule;
  final String? withdrawFee;
  final String? minAmount;
  final String? maxAmount;

  WithdrawRuleDetailRes({
    this.withdrawRule,
    this.withdrawFee,
    this.minAmount,
    this.maxAmount,
  });

  factory WithdrawRuleDetailRes.fromJson(Map<String, dynamic> json) =>
      _$WithdrawRuleDetailResFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawRuleDetailResToJson(this);
}
