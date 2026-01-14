// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bankcard_list_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankcardListRes _$BankcardListResFromJson(Map<String, dynamic> json) =>
    BankcardListRes()
      ..id = json['id'] as String
      ..bankcardNumber = json['bankcardNumber'] as String?
      ..bankName = json['bankName'] as String?
      ..realName = json['realName'] as String
      ..currency = json['currency'] as String?
      ..bindMobile = json['bindMobile'] as String?
      ..type = json['type'] as String?
      ..pic = json['pic'] as String?;

Map<String, dynamic> _$BankcardListResToJson(BankcardListRes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bankcardNumber': instance.bankcardNumber,
      'bankName': instance.bankName,
      'realName': instance.realName,
      'currency': instance.currency,
      'bindMobile': instance.bindMobile,
      'type': instance.type,
      'pic': instance.pic
    };
