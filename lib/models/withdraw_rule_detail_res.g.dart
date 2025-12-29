// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw_rule_detail_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawRuleDetailRes _$WithdrawRuleDetailResFromJson(
  Map<String, dynamic> json,
) => WithdrawRuleDetailRes(
  withdrawRule: json['withdrawRule'] as String?,
  withdrawFee: json['withdrawFee'] as String?,
  minAmount: json['minAmount'] as String?,
  maxAmount: json['maxAmount'] as String?,
);

Map<String, dynamic> _$WithdrawRuleDetailResToJson(
  WithdrawRuleDetailRes instance,
) => <String, dynamic>{
  'withdrawRule': instance.withdrawRule,
  'withdrawFee': instance.withdrawFee,
  'minAmount': instance.minAmount,
  'maxAmount': instance.maxAmount,
};
