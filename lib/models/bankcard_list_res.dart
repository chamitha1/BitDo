import 'package:json_annotation/json_annotation.dart';
part 'bankcard_list_res.g.dart';

@JsonSerializable()
class BankcardListRes {
  BankcardListRes();

  late String id;
  late String? bankcardNumber;
  late String? bankName;
  late String realName;
  late String? bindMobile;
  String? currency;
  String? type;
  String? pic;

  factory BankcardListRes.fromJson(Map<String, dynamic> json) =>
      _$BankcardListResFromJson(json);
  Map<String, dynamic> toJson() => _$BankcardListResToJson(this);
}
