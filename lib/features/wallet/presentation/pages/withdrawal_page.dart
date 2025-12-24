import 'package:BitDo/constants/sms_constants.dart';
import 'package:BitDo/features/auth/presentation/pages/otp_bottom_sheet.dart';
import 'package:BitDo/features/wallet/presentation/pages/balance_history_page.dart';
import 'package:BitDo/features/wallet/presentation/pages/transaction_history_page.dart';
import 'package:BitDo/features/wallet/presentation/widgets/success_dialog.dart';
import 'package:flutter/material.dart';

class WithdrawalPage extends StatefulWidget {
  const WithdrawalPage({super.key});

  @override
  State<WithdrawalPage> createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends State<WithdrawalPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  double _fee = 0.00;
  bool _isWithdrawAll = false;
  final double _balance = 543488384.94;

  void _calculateFee(String value) {
    setState(() {
      if (value.isEmpty) {
        _fee = 0.00;
        return;
      }
      final amount = double.tryParse(value) ?? 0.0;
      _fee = amount * 0.05;
    });
  }

  void _toggleWithdrawAll() {
    setState(() {
      _isWithdrawAll = !_isWithdrawAll;
      if (_isWithdrawAll) {
        double maxAmount = _balance;
        _amountController.text = maxAmount.toStringAsFixed(2);
        _fee = maxAmount * 0.05;
      } else {
        _amountController.clear();
        _fee = 0.00;
      }
    });
  }

  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _amountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isWithdrawEnabled() {
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    return _addressController.text.isNotEmpty &&
        amount >= 10 &&
        _passwordController.text.isNotEmpty;
  }

  void _handleWithdraw() {
    if (!_isWithdrawEnabled()) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: const Color(0xFF000000).withOpacity(0.4),
      builder: (context) => OtpBottomSheet(
        email: "johnha@gmail.com", // replace with logged-in email
        otpLength: 6,
        bizType: SmsBizType.withdraw,

        onVerifyPin: (pin) async {
          // return await walletApi.verifyWithdrawOtp(smsCode: pin);
          return true; // TEMP
        },

        onResend: () async {
          // return await walletApi.sendWithdrawOtp();
          return true; // TEMP
        },

        onVerified: () {
          Navigator.pop(context);
          showDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: const Color(0xFF000000).withOpacity(0.4),
            builder: (context) => const SuccessDialog(),
          );
        },
      ),
    );
  }

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
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Withdraw Address",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF2E3D5B),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _addressController,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter withdraw address or scan code",
                        hintStyle: const TextStyle(
                          color: Color(0xFFB9C6E2),
                          fontFamily: 'Inter',
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFDAE0EE),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFDAE0EE),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF1D5DE5),
                          ),
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Address book logic
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/icons/withdrawal/book.png',
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Scan logic
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 12.0,
                                  top: 10,
                                  bottom: 10,
                                  left: 4,
                                ),
                                child: Image.asset(
                                  'assets/icons/withdrawal/scan.png',
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Withdraw Amount",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xFF2E3D5B),
                          ),
                        ),
                        const Text(
                          "=543,488.384 USDT",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xFF2E3D5B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: _calculateFee,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "0.00",
                        hintStyle: const TextStyle(
                          color: Color(0xFFB9C6E2),
                          fontFamily: 'Inter',
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFDAE0EE),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFDAE0EE),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF1D5DE5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: _toggleWithdrawAll,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFFDAE0EE),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                  color: _isWithdrawAll
                                      ? const Color(0xFF1D5DE5)
                                      : Colors.transparent,
                                ),
                                child: _isWithdrawAll
                                    ? const Icon(
                                        Icons.check,
                                        size: 12,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Withdraw All",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color(0xFF2E3D5B),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Fee : ${_fee.toStringAsFixed(2)} USDT",
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color(0xFF2E3D5B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Transaction Password",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF2E3D5B),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      onChanged: (_) => setState(() {}),
                      obscureText: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter Transaction Password",
                        hintStyle: const TextStyle(
                          color: Color(0xFF717F9A),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFDAE0EE),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFDAE0EE),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF1D5DE5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    const SizedBox(height: 24),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF9F0),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/icons/withdrawal/lightbulb.png',
                            width: 24,
                            height: 24,
                            color: const Color(0xFF40A372),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Friendly Reminder",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Color(0xFF40A372),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Minimum withdrawal amount: 10 USDT",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color(0xFF40A372),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 130),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: _isWithdrawEnabled()
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFF1D5DE5),
                                    Color(0xFF174AB7),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )
                              : null,
                          color: _isWithdrawEnabled()
                              ? null
                              : const Color(0xFFB9C6E2),
                        ),
                        child: ElevatedButton(
                          onPressed: _isWithdrawEnabled()
                              ? _handleWithdraw
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Withdraw",
                            style: TextStyle(
                              color: _isWithdrawEnabled()
                                  ? Color(0xffFFFFFF)
                                  : Color(0xff717F9A),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xffECEFF5),
            ),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Image.asset(
                'assets/icons/withdrawal/back_arrow.png',
                width: 24,
                height: 24,
              ),
            ),
          ),

          const Text(
            "Blockchain Address",
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Color(0xFF151E2F),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TransactionHistoryPage(),
                ),
              );
            },
            child: Image.asset(
              'assets/icons/withdrawal/clock.png',
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}
