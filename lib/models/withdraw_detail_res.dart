class WithdrawDetailRes {
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
  final String? remark; 

  WithdrawDetailRes({
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
    this.remark,
  });

  factory WithdrawDetailRes.fromJson(Map<String, dynamic> json) {
    return WithdrawDetailRes(
      id: (json['id'] ?? json['withdrawId'])?.toString() ?? '',
      userId: (json['userId'] ?? json['user_id'])?.toString() ?? '',
      amount: (json['amount'])?.toString() ?? '0',
      actualAmount: (json['actualAmount'] ?? json['actual_amount'])?.toString() ?? '0',
      fee: (json['fee'])?.toString() ?? '0',
      currency: (json['currency'])?.toString() ?? '',
      status: (json['status'])?.toString() ?? '',
      createDatetime: (json['createDatetime'] ?? json['create_datetime']) is int 
          ? (json['createDatetime'] ?? json['create_datetime']).toString() 
          : (json['createDatetime'] ?? json['create_datetime'])?.toString() ?? '',
      payDatetime: (json['payDatetime'] ?? json['pay_datetime'])?.toString(),
      applyDatetime: (json['applyDatetime'] ?? json['apply_datetime'])?.toString(),
      payCardNo: (json['payCardNo'] ?? json['pay_card_no'] ?? json['address'])?.toString(), 
      payCardName: (json['payCardName'] ?? json['pay_card_name'])?.toString(),
      payBank: (json['payBank'] ?? json['pay_bank'])?.toString(),
      remark: (json['remark'])?.toString(),
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
      'remark': remark,
    };
  }
}
