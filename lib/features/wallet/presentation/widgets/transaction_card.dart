import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionCard extends StatelessWidget {
  final bool isDeposit;
  final String amount;
  final String date;

  const TransactionCard({
    super.key,
    required this.isDeposit,
    required this.amount,
    required this.date,
  });

  // String shortAddress(String value, {int visible = 12}) {
  //   if (value.length <= visible) return value;
  //   return "${value.substring(0, visible)}....";
  // }

  String shortAddressMiddle(String value) {
    if (value.length <= 12) return value;
    return "${value.substring(0, 6)}....${value.substring(value.length - 4)}";
  }

  @override
  Widget build(BuildContext context) {
    final amountColor = isDeposit
        ? const Color(0xff2ECC71)
        : const Color(0xffE74C3C);

    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFF3F4F6), width: 1),
            ),
            child: Center(
              child: Icon(
                isDeposit ? Icons.download : Icons.upload,
                size: 20.w,
                color: isDeposit
                    ? const Color(0xff2ECC71)
                    : const Color(0xffE74C3C),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Amount Change",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff151E2F),
                  ),
                ),
                SizedBox(height: 4.w),
                Text(
                  date,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff9CA3AF),
                  ),
                ),
              ],
            ),
          ),

          Text(
            (isDeposit ? "+" : "-") + amount,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}
