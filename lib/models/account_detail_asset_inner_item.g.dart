// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_detail_asset_inner_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDetailAssetInnerItem _$AccountDetailAssetInnerItemFromJson(
  Map<String, dynamic> json,
) => AccountDetailAssetInnerItem()
  ..accountNumber = json['accountNumber'] as String
  ..type = json['type'] as String
  ..currency = json['currency'] as String
  ..cname = json['cname'] as String
  ..ename = json['ename'] as String
  ..address = json['address'] as String?
  ..totalAmount = json['totalAmount'] as String
  ..usableAmount = json['usableAmount'] as String
  ..icon = json['icon'] as String
  ..pic1 = json['pic1'] as String?
  ..microFlag = json['microFlag'] as String
  ..frozenAmount = json['frozenAmount'] as String
  ..lockAmount = json['lockAmount'] as String
  ..scalpFlag = json['scalpFlag'] as String?
  ..amountUsdt = json['amountUsdt'] as String
  ..totalAsset = json['totalAsset'] as String
  ..totalAssetCurrency = json['totalAssetCurrency'] as String
  ..lockAmountUsdt = json['lockAmountUsdt'] as String
  ..lockTotalAsset = json['lockTotalAsset'] as String
  ..lockTotalAssetCurrency = json['lockTotalAssetCurrency'] as String
  ..precision = json['precision'] as String?;

Map<String, dynamic> _$AccountDetailAssetInnerItemToJson(
  AccountDetailAssetInnerItem instance,
) => <String, dynamic>{
  'accountNumber': instance.accountNumber,
  'type': instance.type,
  'currency': instance.currency,
  'cname': instance.cname,
  'ename': instance.ename,
  'address': instance.address,
  'totalAmount': instance.totalAmount,
  'usableAmount': instance.usableAmount,
  'icon': instance.icon,
  'pic1': instance.pic1,
  'microFlag': instance.microFlag,
  'frozenAmount': instance.frozenAmount,
  'lockAmount': instance.lockAmount,
  'scalpFlag': instance.scalpFlag,
  'amountUsdt': instance.amountUsdt,
  'totalAsset': instance.totalAsset,
  'totalAssetCurrency': instance.totalAssetCurrency,
  'lockAmountUsdt': instance.lockAmountUsdt,
  'lockTotalAsset': instance.lockTotalAsset,
  'lockTotalAssetCurrency': instance.lockTotalAssetCurrency,
  'precision': instance.precision,
};
