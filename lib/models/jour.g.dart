// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jour.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Jour _$JourFromJson(Map<String, dynamic> json) => Jour(
  id: json['id'] as String?,
  type: json['type'] as String?,
  userId: json['userId'] as String?,
  accountNumber: json['accountNumber'] as String?,
  accountType: json['accountType'] as String?,
  currency: json['currency'] as String?,
  bizCategory: json['bizCategory'] as String?,
  bizCategoryNote: json['bizCategoryNote'] as String?,
  bizType: json['bizType'] as String?,
  bizNote: json['bizNote'] as String?,
  refNo: json['refNo'] as String?,
  transAmount: json['transAmount'] as String?,
  preAmount: json['preAmount'] as String?,
  postAmount: json['postAmount'] as String?,
  prevJourCode: json['prevJourCode'] as String?,
  status: json['status'] as String?,
  remark: json['remark'] as String?,
  createDatetime: json['createDatetime'],
  channelType: json['channelType'] as String?,
);

Map<String, dynamic> _$JourToJson(Jour instance) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'userId': instance.userId,
  'accountNumber': instance.accountNumber,
  'accountType': instance.accountType,
  'currency': instance.currency,
  'bizCategory': instance.bizCategory,
  'bizCategoryNote': instance.bizCategoryNote,
  'bizType': instance.bizType,
  'bizNote': instance.bizNote,
  'refNo': instance.refNo,
  'transAmount': instance.transAmount,
  'preAmount': instance.preAmount,
  'postAmount': instance.postAmount,
  'prevJourCode': instance.prevJourCode,
  'status': instance.status,
  'remark': instance.remark,
  'createDatetime': instance.createDatetime,
  'channelType': instance.channelType,
};
