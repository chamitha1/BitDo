import 'package:json_annotation/json_annotation.dart';
part 'account_detail_asset_inner_item.g.dart';

@JsonSerializable()
class AccountDetailAssetInnerItem {
  AccountDetailAssetInnerItem();

  late String accountNumber;
  late String type;
  late String currency;
  late String cname;
  late String ename;
  String? address;
  late String totalAmount;
  late String usableAmount;
  late String icon;
  String? pic1;
  late String microFlag;
  late String frozenAmount;
  late String lockAmount;
  String? scalpFlag;
  late String amountUsdt;
  late String totalAsset;
  late String totalAssetCurrency;
  late String lockAmountUsdt;
  late String lockTotalAsset;
  late String lockTotalAssetCurrency;
  String? precision;

  factory AccountDetailAssetInnerItem.fromJson(Map<String, dynamic> json) {
    // Handle null values by providing defaults
    return AccountDetailAssetInnerItem()
      ..accountNumber = json['accountNumber'] as String? ?? ''
      ..type = json['type'] as String? ?? ''
      ..currency = json['currency'] as String? ?? ''
      ..cname = json['cname'] as String? ?? ''
      ..ename = json['ename'] as String? ?? ''
      ..address = json['address'] as String?
      ..totalAmount = json['totalAmount'] as String? ?? '0'
      ..usableAmount = json['usableAmount'] as String? ?? '0'
      ..icon = json['icon'] as String? ?? ''
      ..pic1 = json['pic1'] as String?
      ..microFlag = json['microFlag'] as String? ?? ''
      ..frozenAmount = json['frozenAmount'] as String? ?? '0'
      ..lockAmount = json['lockAmount'] as String? ?? '0'
      ..scalpFlag = json['scalpFlag'] as String?
      ..amountUsdt = json['amountUsdt'] as String? ?? '0'
      ..totalAsset = json['totalAsset'] as String? ?? '0'
      ..totalAssetCurrency = json['totalAssetCurrency'] as String? ?? ''
      ..lockAmountUsdt = json['lockAmountUsdt'] as String? ?? '0'
      ..lockTotalAsset = json['lockTotalAsset'] as String? ?? '0'
      ..lockTotalAssetCurrency = json['lockTotalAssetCurrency'] as String? ?? ''
      ..precision = json['precision'] as String?;
  }

  Map<String, dynamic> toJson() => _$AccountDetailAssetInnerItemToJson(this);

  AccountDetailAssetInnerItem copyWith({
    String? accountNumber,
    String? type,
    String? currency,
    String? cname,
    String? ename,
    String? address,
    String? totalAmount,
    String? usableAmount,
    String? icon,
    String? pic1,
    String? microFlag,
    String? frozenAmount,
    String? lockAmount,
    String? scalpFlag,
    String? amountUsdt,
    String? totalAsset,
    String? totalAssetCurrency,
    String? lockAmountUsdt,
    String? lockTotalAsset,
    String? lockTotalAssetCurrency,
    String? precision,
  }) {
    return AccountDetailAssetInnerItem()
      ..accountNumber = accountNumber ?? this.accountNumber
      ..type = type ?? this.type
      ..currency = currency ?? this.currency
      ..cname = cname ?? this.cname
      ..ename = ename ?? this.ename
      ..address = address ?? this.address
      ..totalAmount = totalAmount ?? this.totalAmount
      ..usableAmount = usableAmount ?? this.usableAmount
      ..icon = icon ?? this.icon
      ..pic1 = pic1 ?? this.pic1
      ..microFlag = microFlag ?? this.microFlag
      ..frozenAmount = frozenAmount ?? this.frozenAmount
      ..lockAmount = lockAmount ?? this.lockAmount
      ..scalpFlag = scalpFlag ?? this.scalpFlag
      ..amountUsdt = amountUsdt ?? this.amountUsdt
      ..totalAsset = totalAsset ?? this.totalAsset
      ..totalAssetCurrency = totalAssetCurrency ?? this.totalAssetCurrency
      ..lockAmountUsdt = lockAmountUsdt ?? this.lockAmountUsdt
      ..lockTotalAsset = lockTotalAsset ?? this.lockTotalAsset
      ..lockTotalAssetCurrency =
          lockTotalAssetCurrency ?? this.lockTotalAssetCurrency
      ..precision = precision ?? this.precision;
  }
}
