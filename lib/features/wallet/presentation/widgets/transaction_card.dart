import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final bool isDeposit;
  final String amount;
  final String status;
  final String address;
  final String date;

  const TransactionCard({
    super.key,
    required this.isDeposit,
    required this.amount,
    required this.status,
    required this.address,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final amountColor = isDeposit
        ? const Color(0xff2ECC71)
        : const Color(0xffE74C3C);

    final isCompleted = status == "Completed";
    final statusBgColor = isCompleted
        ? const Color(0xffEAF9F0)
        : const Color(0xffFFFBF6);
    final statusTextColor = isCompleted
        ? const Color(0xff40A372)
        : const Color(0xffFF9B29);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: amountColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: statusTextColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isDeposit ? "From" : "Address",
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff454F63),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff151E2F),
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Arrival Date & Time",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff454F63),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff151E2F),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
