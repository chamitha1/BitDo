import 'package:flutter/material.dart';
import '../widgets/transaction_card.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  bool _isDeposit = true;

  final List<Map<String, dynamic>> _depositTransactions = [
    {
      'amount': '+73,364.84 USDT',
      'status': 'Completed',
      'address': '498P4J49pd4784H37',
      'date': '12 Dec 2025, 11:10 am',
    },
    {
      'amount': '+73,364.84 USDT',
      'status': 'Completed',
      'address': '498P4J49pd4784H37',
      'date': '12 Dec 2025, 11:10 am',
    },
    {
      'amount': '+73,364.84 USDT',
      'status': 'Completed',
      'address': '498P4J49pd4784H37',
      'date': '12 Dec 2025, 11:10 am',
    },
    {
      'amount': '+73,364.84 USDT',
      'status': 'Completed',
      'address': '498P4J49pd4784H37',
      'date': '12 Dec 2025, 11:10 am',
    },
  ];

  final List<Map<String, dynamic>> _withdrawTransactions = [
    {
      'amount': '-73,364.84 USDT',
      'status': 'In Broadcasting',
      'address': '498P4J49pd4784H37',
      'date': '12 Dec 2025, 11:10 am',
    },
    {
      'amount': '-73,364.84 USDT',
      'status': 'In Broadcasting',
      'address': '498P4J49pd4784H37',
      'date': '12 Dec 2025, 11:10 am',
    },
    {
      'amount': '-73,364.84 USDT',
      'status': 'In Broadcasting',
      'address': '498P4J49pd4784H37',
      'date': '12 Dec 2025, 11:10 am',
    },
    {
      'amount': '-73,364.84 USDT',
      'status': 'In Broadcasting',
      'address': '498P4J49pd4784H37',
      'date': '12 Dec 2025, 11:10 am',
    },
    {
      'amount': '-73,364.84 USDT',
      'status': 'In Broadcasting',
      'address': '498P4J49pd4784H37',
      'date': '12 Dec 2025, 11:10 am',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F9FF),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xffECEFF5),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/icons/deposit/arrow_back.png",
                          width: 20,
                          height: 20,
                          color: const Color(0xff151E2F),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "History",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff151E2F),
                    ),
                  ),
                  Image.asset(
                    "assets/icons/home/headphones.png",
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xffF6F9FF),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xffECEFF5), width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isDeposit = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _isDeposit ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: _isDeposit
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 20,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            "Deposit",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _isDeposit
                                  ? const Color(0xff151E2F)
                                  : const Color(0xff929EB8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isDeposit = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: !_isDeposit
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: !_isDeposit
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 20,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            "Withdraw",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: !_isDeposit
                                  ? const Color(0xff151E2F)
                                  : const Color(0xff929EB8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                itemCount: _isDeposit
                    ? _depositTransactions.length
                    : _withdrawTransactions.length,
                itemBuilder: (context, index) {
                  final data = _isDeposit
                      ? _depositTransactions[index]
                      : _withdrawTransactions[index];
                  return TransactionCard(
                    isDeposit: _isDeposit,
                    amount: data['amount'],
                    status: data['status'],
                    address: data['address'],
                    date: data['date'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
