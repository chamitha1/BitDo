// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRes _$LoginResFromJson(Map<String, dynamic> json) => LoginRes()
  ..loginName = json['loginName'] as String
  ..token = json['token'] as String
  ..userId = json['userId'] as String;

Map<String, dynamic> _$LoginResToJson(LoginRes instance) => <String, dynamic>{
  'loginName': instance.loginName,
  'token': instance.token,
  'userId': instance.userId,
};
