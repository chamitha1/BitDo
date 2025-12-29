import 'package:json_annotation/json_annotation.dart';

part 'jour.g.dart';

@JsonSerializable()
class Jour {
  final String? id;
  final String? accountNumber;
  final String? currency;
  @JsonKey(name: 'transAmount')
  final String? amount;
  
  final String? fee;
  
  final String? bizType; // e.g. "1"=Deposit, "2"=Withdraw
  
  @JsonKey(name: 'createDatetime')
  final dynamic createTime; // Can be int or String
  
  @JsonKey(name: 'bizNote')
  final String? remark;
  
  final String? preAmount;
  final String? postAmount;

  Jour({
    this.id,
    this.accountNumber,
    this.currency,
    this.amount,
    this.fee,
    this.bizType,
    this.createTime,
    this.remark,
    this.preAmount,
    this.postAmount,
  });

  factory Jour.fromJson(Map<String, dynamic> json) => _$JourFromJson(json);
  Map<String, dynamic> toJson() => _$JourToJson(this);
}
