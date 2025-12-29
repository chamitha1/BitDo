import "account_detail_asset_inner_item.dart";
import 'package:json_annotation/json_annotation.dart';
part 'account_detail_res.g.dart';

@JsonSerializable()
class AccountDetailAssetRes {
  AccountDetailAssetRes();

  late String totalAmount;
  late String totalAmountCurrency;
  late String totalAsset;
  late String totalAssetCurrency;
  String? lockTotalAmount;
  String? lockTotalAmountCurrency;
  late String microAmount;
  late String microAmountCurrency;
  num? yesterdayIncomeUsdt;
  late List<AccountDetailAssetInnerItem> accountList;

  factory AccountDetailAssetRes.fromJson(Map<String, dynamic> json) {
    // Handle null values by providing defaults
    return AccountDetailAssetRes()
      ..totalAmount = json['totalAmount'] as String? ?? '0'
      ..totalAmountCurrency = json['totalAmountCurrency'] as String? ?? ''
      ..totalAsset = json['totalAsset'] as String? ?? '0'
      ..totalAssetCurrency = json['totalAssetCurrency'] as String? ?? ''
      ..lockTotalAmount = json['lockTotalAmount'] as String?
      ..lockTotalAmountCurrency = json['lockTotalAmountCurrency'] as String?
      ..microAmount = json['microAmount'] as String? ?? '0'
      ..microAmountCurrency = json['microAmountCurrency'] as String? ?? ''
      ..yesterdayIncomeUsdt = json['yesterdayIncomeUsdt'] as num?
      ..accountList =
          (json['accountList'] as List<dynamic>?)
              ?.map(
                (e) => AccountDetailAssetInnerItem.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [];
  }

  Map<String, dynamic> toJson() => _$AccountDetailAssetResToJson(this);

  AccountDetailAssetRes copyWith({
    String? totalAmount,
    String? totalAmountCurrency,
    String? totalAsset,
    String? totalAssetCurrency,
    String? lockTotalAmount,
    String? lockTotalAmountCurrency,
    String? microAmount,
    String? microAmountCurrency,
    num? yesterdayIncomeUsdt,
    List<AccountDetailAssetInnerItem>? accountList,
  }) {
    return AccountDetailAssetRes()
      ..totalAmount = totalAmount ?? this.totalAmount
      ..totalAmountCurrency = totalAmountCurrency ?? this.totalAmountCurrency
      ..totalAsset = totalAsset ?? this.totalAsset
      ..totalAssetCurrency = totalAssetCurrency ?? this.totalAssetCurrency
      ..lockTotalAmount = lockTotalAmount ?? this.lockTotalAmount
      ..lockTotalAmountCurrency =
          lockTotalAmountCurrency ?? this.lockTotalAmountCurrency
      ..microAmount = microAmount ?? this.microAmount
      ..microAmountCurrency = microAmountCurrency ?? this.microAmountCurrency
      ..yesterdayIncomeUsdt = yesterdayIncomeUsdt ?? this.yesterdayIncomeUsdt
      ..accountList = accountList ?? this.accountList;
  }
}
