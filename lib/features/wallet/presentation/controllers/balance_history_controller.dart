import 'package:get/get.dart';
import 'package:BitDo/api/account_api.dart';
import 'package:BitDo/models/account_detail_res.dart';
import 'package:BitDo/models/jour.dart';
import 'package:BitDo/models/account_detail_asset_inner_item.dart';
import 'package:BitDo/models/page_info.dart';

class BalanceHistoryController extends GetxController {
  var currentTab = 0.obs; // 0: All, 1: Deposits, 2: Withdrawals
  var isLoading = false.obs;
  var transactions = <Jour>[].obs;
  var accountDetail = Rxn<AccountDetailAssetRes>();

  // Pagination
  int pageNum = 1;
  final int pageSize = 20;
  bool isEnd = false;

  String? accountNumber;
  String? symbol;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    print("BalanceHistoryController onInit - Args: $args");
    if (args != null && args is Map) {
      accountNumber = args['accountNumber'];
      symbol = args['symbol']; // e.g., "USDT"
    }
    refreshData();
  }

  void changeTab(int index) {
    if (currentTab.value == index) return;
    print("Switching tab to $index");
    currentTab.value = index;
    refreshData();
  }

  Future<void> refreshData() async {
    print("refreshData called. Symbol: $symbol, AccountNumber: $accountNumber");
    isLoading.value = true;
    pageNum = 1;
    isEnd = false;
    transactions.clear();

    try {
      await Future.wait([_fetchBalance(), _fetchTransactions()]);
    } catch (e) {
      print("Error refreshing data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore() async {
    if (isEnd || isLoading.value) return;
    try {
      print("Loading more transactions. Page: ${pageNum + 1}");
      pageNum++;
      await _fetchTransactions();
    } catch (e) {
      print("Error loading more: $e");
      pageNum--;
    }
  }

  Future<void> _fetchBalance() async {
    try {
      print("Fetching balance (all assets)...");
      // Call without assetCurrency to get all assets.
      final res = await AccountApi.getBalanceAccount();
      print("Balance fetched successfully: ${res.totalAmount}");
      accountDetail.value = res;
    } catch (e) {
      print("Fetch balance error: $e");
    }
  }

  Future<void> _fetchTransactions() async {
    final Map<String, dynamic> params = {
      "pageNum": pageNum,
      "pageSize": pageSize,
      // "currency": symbol,
    };

    if (accountNumber != null) {
      params['accountNumber'] = accountNumber;
    } else {
      print("Warning: accountNumber is null in _fetchTransactions");
    }

    print("Fetching transactions with params: $params");

    try {
      final PageInfo<Jour> res = await AccountApi.getJourPageList(params);
      print("Transactions fetched. Count: ${res.list.length}");

      var filteredList = res.list;

      if (currentTab.value == 1) {
        // Deposit
        filteredList = res.list.where((item) {
          final pre = double.tryParse(item.preAmount ?? '0') ?? 0;
          final post = double.tryParse(item.postAmount ?? '0') ?? 0;
          return post > pre || item.bizType == '1';
        }).toList();
      } else if (currentTab.value == 2) {
        // Withdraw
        filteredList = res.list.where((item) {
          final pre = double.tryParse(item.preAmount ?? '0') ?? 0;
          final post = double.tryParse(item.postAmount ?? '0') ?? 0;
          return post < pre || item.bizType == '2';
        }).toList();
      }

      print(
        "Filtered count for tab ${currentTab.value}: ${filteredList.length}",
      );

      if (res.list.isEmpty) {
        isEnd = true;
      } else {
        if (pageNum == 1) {
          transactions.assignAll(filteredList);
        } else {
          transactions.addAll(filteredList);
        }
        if (res.list.length < pageSize) {
          isEnd = true;
        }
      }
    } catch (e) {
      print("Error fetching transactions: $e");
      rethrow;
    }
  }

  // Helper getters for UI
  AccountDetailAssetInnerItem? get _currentAssetItem {
    if (accountDetail.value == null) {
      print("DEBUG: accountDetail.value is null");
      return null;
    }
    if (symbol == null) {
      print("DEBUG: symbol is null in getter");
      return null;
    }
    try {
      final item = accountDetail.value!.accountList.firstWhere(
        (e) => e.currency.toUpperCase() == symbol!.toUpperCase(),
        orElse: () {
          print(
            "DEBUG: Asset not found for symbol: $symbol. Available: ${accountDetail.value!.accountList.map((e) => e.currency).toList()}",
          );
          throw Exception("Not found");
        },
      );
      return item;
    } catch (e) {
      if (e.toString() != "Exception: Not found") {
        print("DEBUG: Error finding asset: $e");
      }
      return null;
    }
  }

  String get totalBalance => _currentAssetItem?.totalAmount ?? "0.00";
  String get frozen => _currentAssetItem?.frozenAmount ?? "0.00";
  String get valuationUsdt => _currentAssetItem?.amountUsdt ?? "0.00";

  String get valuationOther => _currentAssetItem?.totalAsset ?? "0.00";
}
