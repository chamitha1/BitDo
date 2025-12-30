// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawRequest _$WithdrawRequestFromJson(Map<String, dynamic> json) =>
    WithdrawRequest(
      accountNumber: json['accountNumber'] as String,
      amount: json['amount'] as String,
      payCardNo: json['payCardNo'] as String,
      tradePwd: json['tradePwd'] as String,
      smsCaptcha: json['smsCaptcha'] as String,
      googleSecret: json['googleSecret'] as String?,
      currency: json['currency'] as String,
      bizType: json['bizType'] as String,
      bizCategory: json['bizCategory'] as String,
    );

Map<String, dynamic> _$WithdrawRequestToJson(WithdrawRequest instance) =>
    <String, dynamic>{
      'accountNumber': instance.accountNumber,
      'amount': instance.amount,
      'payCardNo': instance.payCardNo,
      'tradePwd': instance.tradePwd,
      'smsCaptcha': instance.smsCaptcha,
      'googleSecret': instance.googleSecret,
      'currency': instance.currency,
      'bizType': instance.bizType,
      'bizCategory': instance.bizCategory,
    };
