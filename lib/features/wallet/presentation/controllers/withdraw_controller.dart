import 'package:BitDo/api/account_api.dart';
import 'package:BitDo/models/withdraw_rule_detail_res.dart';
import 'package:BitDo/models/account.dart'; // Added
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BitDo/api/user_api.dart';
import 'package:BitDo/constants/sms_constants.dart';
import 'package:BitDo/core/storage/storage_service.dart';
import 'package:BitDo/features/auth/presentation/pages/bind_trade_pwd_sheet.dart';
import 'package:BitDo/features/home/presentation/controllers/balance_controller.dart';
import 'package:BitDo/features/wallet/presentation/widgets/success_dialog.dart';
import 'package:BitDo/models/jour.dart';

class WithdrawController extends GetxController {
  final TextEditingController addrController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController tradeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController googleController = TextEditingController();

  var isLoading = false.obs;
  var ruleInfo = Rxn<WithdrawRuleDetailRes>();
  var availableAmount = '0.00'.obs;
  var note = ''.obs;
  var symbol = ''.obs;
  var accountNumber = ''.obs;
  var lastWithdrawTransaction = Rxn<Jour>();

  @override
  void onInit() {
    super.onInit();

    if (Get.parameters.containsKey('symbol')) {
      symbol.value = Get.parameters['symbol'] ?? '';
      getInitData();
    }
  }

  void setArgs(String symbolVal, String accountNumVal) {
    symbol.value = symbolVal;
    accountNumber.value = accountNumVal;
    getInitData();
  }

  void getInitData() async {
    if (symbol.value.isEmpty) {
      print("Symbol is empty");
      return;
    }

    try {
      isLoading.value = true;

      // 1. Fetch Rules
      print("Fetching rules for ${symbol.value}...");
      final ruleRes = await AccountApi.getWithdrawRuleDetail(symbol.value);

      // 2. Fetch Account Balance
      print("Fetching details for ${symbol.value}...");
      final accountRes = await AccountApi.getDetailAccount(symbol.value);

      ruleInfo.value = ruleRes;
      note.value = ruleRes.withdrawRule ?? 'No special rules.';

      availableAmount.value = accountRes.usableAmount?.toString() ?? '0.00';
    } catch (e) {
      print("Error fetching withdraw init data: $e");

      note.value = "Unable to load withdrawal details. Please try again later.";
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> beforeSend() async {
    final payCardNo = addrController.text.trim();
    final amount = amountController.text.trim();
    final tradePwd = tradeController.text.trim();

    if (payCardNo.isEmpty) {
      Get.snackbar("Error", "Please enter withdrawal address or scan QR");
      return false;
    } else if (amount.isEmpty) {
      Get.snackbar("Error", "Please enter withdrawal amount");
      return false;
    } else if (double.tryParse(amount) == null) {
      Get.snackbar("Error", "Invalid amount");
      return false;
    } else if (tradePwd.isEmpty) {
      Get.snackbar("Error", "Please enter transaction password");
      return false;
    }

    try {
      isLoading.value = true;
      await AccountApi.withdrawCheck({
        "accountNumber": accountNumber.value,
        "amount": amount,
        "payCardNo": payCardNo,
        "tradePwd": tradePwd,
      });
      return true;
    } catch (e) {
      print("Withdraw check error: $e");
      
   
      final errorMsg = e.toString().toLowerCase();
      if (errorMsg.contains("password") && (errorMsg.contains("set") || errorMsg.contains("bind") || errorMsg.contains("empty"))) {
         _showBindTradePwdSheet();
      } else {
         Get.snackbar("Error", "Check failed: ${e.toString()}");
      }
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void _showBindTradePwdSheet() async {
    final email = await StorageService.getUserName();
    if (email == null) {
      Get.snackbar("Error", "Please login again");
      return;
    }
    
    Get.bottomSheet(
      BindTradePwdSheet(
        email: email,
        onSuccess: () {
           // 
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void updateAddressFromScan(String scannedCode) {
    if (scannedCode.isNotEmpty) {
      addrController.text = scannedCode;
    }
  }

  Future<bool> sendOtp() async {
    final email = await StorageService.getUserName();
    if (email == null || email.isEmpty) {
      Get.snackbar("Error", "User email not found. Please login again.");
      return false;
    }

    try {
      final success = await UserApi().sendOtp(
        email: email,
        bizType: SmsBizType.withdraw,
      );
      return success;
    } catch (e) {
      print("Send OTP error: $e");
      Get.snackbar("Error", "Failed to send OTP: $e");
      return false;
    }
  }

  Future<bool> onApplyTap() async {
    final payCardNo = addrController.text.trim();
    final amount = amountController.text.trim();
    final tradePwd = tradeController.text.trim();
    final smsCaptcha = emailController.text.trim();
    final googleSecret = googleController.text.trim();

    if (payCardNo.isEmpty) {
      Get.snackbar("Error", "Please enter withdrawal address");
      return false;
    }
    if (amount.isEmpty) {
      Get.snackbar("Error", "Please enter amount");
      return false;
    }
    if (tradePwd.isEmpty) {
      Get.snackbar("Error", "Please enter transaction password");
      return false;
    }
    if (smsCaptcha.isEmpty) {
      Get.snackbar("Error", "Please enter email verification code");
      return false;
    }

    try {
      isLoading.value = true;
      await AccountApi.createWithdraw({
        "accountNumber": accountNumber.value,
        "amount": amount,
        "payCardNo": payCardNo,
        "tradePwd": tradePwd,
        "smsCaptcha": smsCaptcha,
        "googleSecret": googleSecret,
      });

      // Dynamic Balance Update
      try {
        final currentBalance = double.tryParse(availableAmount.value.replaceAll(',', '')) ?? 0.0;
        final withdrawAmount = double.tryParse(amount) ?? 0.0;
        final newBalance = currentBalance - withdrawAmount;
        availableAmount.value = newBalance.toStringAsFixed(8); // Keep precision
        
        // Refresh global balance
        if (Get.isRegistered<BalanceController>()) {
          Get.find<BalanceController>().updateOptimisticBalance(symbol.value, withdrawAmount);
        }
      } catch (e) {
        print("Error updating local balance: $e");
      }

      final newTx = Jour(
        id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
        amount: amount,
        bizType: '2', // Withdraw
        currency: symbol.value,
        createTime: DateTime.now().millisecondsSinceEpoch,
        remark: 'Processing',
        accountNumber: accountNumber.value,
      );

      lastWithdrawTransaction.value = newTx;
      return true;
    } catch (e) {
      print("Create withdraw error: $e");
      Get.snackbar("Error", "Withdrawal failed: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void setAddress(String address) {
    addrController.text = address;
  }

  void setMaxAmount() {
    amountController.text = availableAmount.value;
  }

  @override
  void onClose() {
    addrController.dispose();
    amountController.dispose();
    tradeController.dispose();
    emailController.dispose();
    googleController.dispose();
    super.onClose();
  }
}
