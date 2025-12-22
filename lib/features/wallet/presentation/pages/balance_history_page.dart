import 'package:flutter/material.dart';

class BalanceHistoryPage extends StatelessWidget {
  const BalanceHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FF),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBalanceCard(),
                    const SizedBox(height: 24),
                    const Text(
                      "Transaction History",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Color(0xff151E2F),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // const SizedBox(height: 16),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final isReceive = index == 0 || index == 3;
                        return _buildTransactionItem(
                          isReceive: isReceive,
                          date: "12 Dec 2025, 11:10 am",
                          amount: isReceive
                              ? "+73,364.84 USDT"
                              : "-73,364.84 USDT",
                          fee: "Advertising Fee",
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem({
    required bool isReceive,
    required String date,
    required String amount,
    required String fee,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isReceive
                  ? const Color(0xFFEAF9F0)
                  : const Color(0xFFFDECEB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              isReceive
                  ? 'assets/icons/balance_history/card_receive.png'
                  : 'assets/icons/balance_history/card_send.png',
              width: 24,
              height: 24,
              color: isReceive
                  ? const Color(0xFF40A372)
                  : const Color(0xFFE74C3C),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Cooder",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xFF151E2F),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF151E2F),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: isReceive
                      ? const Color(0xFF40A372)
                      : const Color(0xFFE74C3C),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                fee,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xFF454F63),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 56,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF1D5DE5), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: const Color(0xFFF6F9FF),
                ),
                child: const Text(
                  "Withdraw",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF1D5DE5),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D5DE5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Deposit",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFECEFF5),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/icons/deposit/arrow_back.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              const SizedBox(width: 40), // Spacer to balance
            ],
          ),
          const Text(
            "Balance & History",
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Color(0xFF151E2F),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 24),
          padding: const EdgeInsets.fromLTRB(20, 44, 20, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _buildBalanceRow("Total", "203,372.478343"),
              const SizedBox(height: 8),
              _buildBalanceRow("Available Balance", "432.787774"),
              const SizedBox(height: 8),
              _buildBalanceRow("Frozen", "232"),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 14.0),
                child: Divider(color: Color(0xFFF1F4F9), height: 1),
              ),
              _buildBalanceRow("Valuation (USDT)", "203,372.478343"),
              const SizedBox(height: 8),
              _buildBalanceRow("Valuation (USD)", "213"),
            ],
          ),
        ),
        Positioned(
          top: -12,
          child: Container(
            padding: const EdgeInsets.all(0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: Image.asset(
              'assets/icons/balance_history/usdt.png',
              width: 65,
              height: 65,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xFF454F63),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Color(0xFF151E2F),
          ),
        ),
      ],
    );
  }
}
