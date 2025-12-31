class WithdrawPageRes {
  final String id;
  final String userId;
  final String amount;
  final String actualAmount;
  final String fee;
  final String currency;
  final String status;
  final String createDatetime;
  final String? payDatetime;
  final String? applyDatetime;
  final String? payCardNo;
  final String? payCardName;
  final String? payBank;

  WithdrawPageRes({
    required this.id,
    required this.userId,
    required this.amount,
    required this.actualAmount,
    required this.fee,
    required this.currency,
    required this.status,
    required this.createDatetime,
    this.payDatetime,
    this.applyDatetime,
    this.payCardNo,
    this.payCardName,
    this.payBank,
  });

  factory WithdrawPageRes.fromJson(Map<String, dynamic> json) {
    return WithdrawPageRes(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      amount: json['amount']?.toString() ?? '0',
      actualAmount: json['actualAmount']?.toString() ?? '0',
      fee: json['fee']?.toString() ?? '0',
      currency: json['currency']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      createDatetime: json['createDatetime'] is int 
          ? json['createDatetime'].toString() 
          : json['createDatetime']?.toString() ?? '',
      payDatetime: json['payDatetime']?.toString(),
      applyDatetime: json['applyDatetime']?.toString(),
      payCardNo: json['payCardNo']?.toString(),
      payCardName: json['payCardName']?.toString(),
      payBank: json['payBank']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'amount': amount,
      'actualAmount': actualAmount,
      'fee': fee,
      'currency': currency,
      'status': status,
      'createDatetime': createDatetime,
      'payDatetime': payDatetime,
      'applyDatetime': applyDatetime,
      'payCardNo': payCardNo,
      'payCardName': payCardName,
      'payBank': payBank,
    };
  }
}
