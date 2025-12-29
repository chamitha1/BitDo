import 'package:get/get.dart';
import 'package:BitDo/api/account_api.dart';
import 'package:BitDo/models/account_detail_res.dart';
import 'package:BitDo/models/account_detail_asset_inner_item.dart';
import 'package:BitDo/core/storage/storage_service.dart';
import 'package:BitDo/features/auth/presentation/controllers/user_controller.dart';

class BalanceController extends GetxController {
  final Rx<AccountDetailAssetRes?> balanceData = Rx<AccountDetailAssetRes?>(
    null,
  );
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  final RxString selectedCurrency = RxString('');

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
      return null;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchBalance();
  }

  Future<void> fetchBalance() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final currency = await StorageService.getCurrency();
      final res = await AccountApi.getBalanceAccount(assetCurrency: currency);

      print("BalanceController: Fetched data successfully");
      balanceData.value = res;

      if (res.accountList.isNotEmpty) {
        if (selectedCurrency.value.isEmpty ||
            !res.accountList.any((e) => e.currency == selectedCurrency.value)) {
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

    final exists = balanceData.value!.accountList.any(
      (e) => e.currency == newCurrency,
    );
    if (exists) {
      selectedCurrency.value = newCurrency;
    }
  }
}
