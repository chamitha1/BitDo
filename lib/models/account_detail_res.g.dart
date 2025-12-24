// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_detail_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDetailAssetRes _$AccountDetailAssetResFromJson(
  Map<String, dynamic> json,
) => AccountDetailAssetRes()
  ..totalAmount = json['totalAmount'] as String
  ..totalAmountCurrency = json['totalAmountCurrency'] as String
  ..totalAsset = json['totalAsset'] as String
  ..totalAssetCurrency = json['totalAssetCurrency'] as String
  ..lockTotalAmount = json['lockTotalAmount'] as String?
  ..lockTotalAmountCurrency = json['lockTotalAmountCurrency'] as String?
  ..microAmount = json['microAmount'] as String
  ..microAmountCurrency = json['microAmountCurrency'] as String
  ..yesterdayIncomeUsdt = json['yesterdayIncomeUsdt'] as num?
  ..accountList = (json['accountList'] as List<dynamic>)
      .map(
        (e) => AccountDetailAssetInnerItem.fromJson(e as Map<String, dynamic>),
      )
      .toList();

Map<String, dynamic> _$AccountDetailAssetResToJson(
  AccountDetailAssetRes instance,
) => <String, dynamic>{
  'totalAmount': instance.totalAmount,
  'totalAmountCurrency': instance.totalAmountCurrency,
  'totalAsset': instance.totalAsset,
  'totalAssetCurrency': instance.totalAssetCurrency,
  'lockTotalAmount': instance.lockTotalAmount,
  'lockTotalAmountCurrency': instance.lockTotalAmountCurrency,
  'microAmount': instance.microAmount,
  'microAmountCurrency': instance.microAmountCurrency,
  'yesterdayIncomeUsdt': instance.yesterdayIncomeUsdt,
  'accountList': instance.accountList,
};
