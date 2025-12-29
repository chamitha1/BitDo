// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw_page_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawPageRes _$WithdrawPageResFromJson(Map<String, dynamic> json) =>
    WithdrawPageRes(
      id: json['id'] as String,
      userId: json['userId'] as String,
      amount: json['amount'] as String,
      actualAmount: json['actualAmount'] as String,
      fee: json['fee'] as String,
      currency: json['currency'] as String,
      status: json['status'] as String,
      createDatetime: json['createDatetime'] as String,
      payDatetime: json['payDatetime'] as String?,
      applyDatetime: json['applyDatetime'] as String?,
      payCardNo: json['payCardNo'] as String?,
      payCardName: json['payCardName'] as String?,
      payBank: json['payBank'] as String?,
    );

Map<String, dynamic> _$WithdrawPageResToJson(WithdrawPageRes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'amount': instance.amount,
      'actualAmount': instance.actualAmount,
      'fee': instance.fee,
      'currency': instance.currency,
      'status': instance.status,
      'createDatetime': instance.createDatetime,
      'payDatetime': instance.payDatetime,
      'applyDatetime': instance.applyDatetime,
      'payCardNo': instance.payCardNo,
      'payCardName': instance.payCardName,
      'payBank': instance.payBank,
    };
