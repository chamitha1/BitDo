import 'package:get/get.dart';
import 'package:BitDo/api/account_api.dart';
import 'package:BitDo/models/account_detail_res.dart';
import 'package:BitDo/models/account_detail_asset_inner_item.dart';
import 'package:BitDo/core/storage/storage_service.dart';
import 'package:BitDo/features/auth/presentation/controllers/user_controller.dart';

class BalanceController extends GetxController {
  // State
  final Rx<AccountDetailAssetRes?> balanceData = Rx<AccountDetailAssetRes?>(null);
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  
  // Selection
  final RxString selectedCurrency = RxString('');

  // Computed
  AccountDetailAssetInnerItem? get selectedAsset {
    if (balanceData.value == null || selectedCurrency.value.isEmpty) {
      return null;
    }
    
    // Find the specific asset in the list
    try {
      return balanceData.value!.accountList.firstWhere(
        (element) => element.currency == selectedCurrency.value,
      );
    } catch (_) {
      // If not found, try to default or return null
      return null;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchBalance();
  }

  Future<void> fetchBalance() async {
    // Prevent duplicate calls if already loading? 
    // We want to allow pull-to-refresh, so we won't strictly block it, 
    // but the initial call in onInit handles the startup.
    
    // If it's a pull-to-refresh, we might not want to set isLoading to true causing a flicker,
    // but for now, let's keep it simple.
    
    // Note: If we want to prevent redundancy when multiple widgets mount simultaneously,
    // we can check if a request is already in flight.
    // For now, relying on Get.put() singleton behavior is the first step.
    
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final currency = await StorageService.getCurrency();
      final res = await AccountApi.getBalanceAccount(
        assetCurrency: currency,
      );

      print("BalanceController: Fetched data successfully");
      balanceData.value = res;

      // Logic from original WalletCard
      if (res.accountList.isNotEmpty) {
        // Set default selected currency if none or invalid
        if (selectedCurrency.value.isEmpty || 
            !res.accountList.any((e) => e.currency == selectedCurrency.value)) {
           // Default to first one or USDT? Original code had hardcoded defaults.
           // Let's default to the first one in the list for now.
           selectedCurrency.value = res.accountList.first.currency;
        }

        final accNum = res.accountList.first.accountNumber;
        await StorageService.saveAccountNumber(accNum);

        if (Get.isRegistered<UserController>()) {
          Get.find<UserController>().setUserName(accNum);
        }
      }
    } catch (e) {
      print("BalanceController Error: $e");
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void onChangeCurrency(String newCurrency) {
    if (balanceData.value == null) return;
    
    final exists = balanceData.value!.accountList.any((e) => e.currency == newCurrency);
    if (exists) {
      selectedCurrency.value = newCurrency;
    }
  }
}
