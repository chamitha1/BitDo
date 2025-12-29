// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jour.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Jour _$JourFromJson(Map<String, dynamic> json) => Jour(
  id: json['id'] as String?,
  accountNumber: json['accountNumber'] as String?,
  currency: json['currency'] as String?,
  amount: json['transAmount'] as String?,
  fee: json['fee'] as String?,
  bizType: json['bizType'] as String?,
  createTime: json['createDatetime'],
  remark: json['bizNote'] as String?,
  preAmount: json['preAmount'] as String?,
  postAmount: json['postAmount'] as String?,
);

Map<String, dynamic> _$JourToJson(Jour instance) => <String, dynamic>{
  'id': instance.id,
  'accountNumber': instance.accountNumber,
  'currency': instance.currency,
  'transAmount': instance.amount,
  'fee': instance.fee,
  'bizType': instance.bizType,
  'createDatetime': instance.createTime,
  'bizNote': instance.remark,
  'preAmount': instance.preAmount,
  'postAmount': instance.postAmount,
};
