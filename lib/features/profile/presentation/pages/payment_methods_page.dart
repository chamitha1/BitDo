import 'package:BitOwi/api/account_api.dart';
import 'package:BitOwi/config/routes.dart';
import 'package:BitOwi/core/widgets/common_appbar.dart';
import 'package:BitOwi/core/widgets/primary_button.dart';
import 'package:BitOwi/core/widgets/soft_circular_loader.dart';
import 'package:BitOwi/features/profile/presentation/controllers/settings_controller.dart';
import 'package:BitOwi/models/bankcard_list_res.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PaymentMethodsPage extends StatefulWidget {
  PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  List<BankcardListRes> list = [];
  late EasyRefreshController _controller;
  // late StreamSubscription<BankcardEditEvent> beStream;
  // bool canChose = false;
  bool isEnd = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController(controlFinishRefresh: true);
    // beStream = EventBusUtil.listenBankcardEdit((event) {
    getBankcardList();
    // });
    // canChose = Get.parameters['chose'] == '1';
  }

  @override
  void dispose() {
    _controller.dispose();
    // beStream.cancel();
    super.dispose();
  }

  Future<void> getBankcardList() async {
    if (isLoading) return;
    try {
      setState(() {
        isLoading = true;
      });
      final resList = await AccountApi.getBankCardList();
      if (!mounted) return;
      setState(() {
        list = resList;
        isEnd = true;
      });
    } catch (e) {
      print("getBankcardList getList error: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    _controller.finishRefresh();
  }

  Future<void> onAddTap() async {
    // Get.toNamed(Routes.selectPaymentMethod);
  }

  void postDelete(int index) {
    setState(() {
      list.removeAt(index);
    });
  }

  bool get isEmpty {
    return isEnd && list.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: CommonAppBar(title: "Payment Methods", onBack: () => Get.back()),
      body: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Payment methods list
              Expanded(
                child: EasyRefresh(
                  controller: _controller,
                  onRefresh: getBankcardList,
                  refreshOnStart: true,
                  // onLoad: onLoad,
                  child: isLoading
                      ? const SoftCircularLoader()
                      : isEmpty
                      ? const Center(
                          child: Text(
                            "No payment methods added",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.only(top: 20),
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return buildPaymentMethodCard(list[index], index);
                          },
                        ),
                ),
              ),
              // Add Payment Method button
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0, top: 20),
                child: buildAddPaymentButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _maskAccount(String value) {
    if (value.length <= 4) return value;
    final last4 = value.substring(value.length - 4);
    return '**** **** **** $last4';
  }

  Widget buildPaymentMethodCard(BankcardListRes item, int index) {
    final displayAccount = item.bankcardNumber?.isNotEmpty == true
        ? _maskAccount(item.bankcardNumber!)
        : item.bindMobile ?? '--';
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left accent bar
          Container(
            width: 6,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFFF9F43), // orange
              borderRadius: BorderRadius.circular(8),
            ),
          ),

          // Bank logo
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F3F7),
                borderRadius: BorderRadius.circular(14),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: item.pic != null
                    ? Image.network(item.pic!, fit: BoxFit.contain)
                    : const Icon(Icons.account_balance),
              ),
            ),
          ),
          // Bank details
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        item.bankName ?? '--',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1D2E),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (item.currency != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF8F0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item.currency ?? '',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2EBD85),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  displayAccount,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF7B8198),
                  ),
                ),
              ],
            ),
          ),
          // Actions
          Row(
            children: [
              _actionIcon(
                asset: 'assets/icons/profile_page/trash_bin.svg',
                bgColor: const Color(0xFFFFF1F1),
                iconColor: const Color(0xFFFF5A5A),
                onTap: () => postDelete(index),
              ),
              const SizedBox(width: 10),
              _actionIcon(
                asset: 'assets/icons/profile_page/edit_pencil.svg',
                bgColor: const Color(0xFFF1F4FA),
                iconColor: const Color(0xFF64748B),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _actionIcon({
    required String asset,
    required Color bgColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: SvgPicture.asset(
            asset,
            width: 18,
            height: 18,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }

  Widget buildAddPaymentButton() {
    return PrimaryButton(
      text: "Add Payment Method",
      enabled: true,
      onPressed: () async {
        final result = await showPaymentMethodBottomSheet();
        if (result == 0) {
          // Bank Card flow
          Get.toNamed(Routes.addBankCardPage);
        } else if (result == 1) {
          // Mobile Money flow
          Get.toNamed(Routes.addMobileMoneyPage);
        }
      },
      // child: const SoftCircularLoader(color: Colors.white),
    );
  }
}

Future<int?> showPaymentMethodBottomSheet() async {
  int? tempSelectedIndex;

  return showModalBottomSheet<int>(
    context: Get.context!,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            padding: const EdgeInsets.only(top: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Header
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Select Payment Method",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.close,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),

                // Options
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _paymentOption(
                        title: "Bank Card",
                        icon: "assets/icons/profile_page/bank_card.svg",
                        iconBgColor: const Color(0xFFFFFBF6),
                        index: 0,
                        selectedIndex: tempSelectedIndex,
                        onTap: () {
                          setModalState(() => tempSelectedIndex = 0);
                        },
                      ),
                      const SizedBox(height: 12),
                      _paymentOption(
                        title: "Mobile Money",
                        icon: "assets/icons/profile_page/mobile_money.svg",
                        iconBgColor: const Color(0xFFFDF4F5),
                        index: 1,
                        selectedIndex: tempSelectedIndex,
                        onTap: () {
                          setModalState(() => tempSelectedIndex = 1);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Proceed button
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: PrimaryButton(
                    text: "Proceed",
                    enabled: tempSelectedIndex != null,
                    onPressed: () {
                      Navigator.pop(context, tempSelectedIndex);
                    },
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _paymentOption({
  required String title,
  required String icon,
  required Color iconBgColor,
  required int index,
  required int? selectedIndex,
  required VoidCallback onTap,
}) {
  final bool isSelected = selectedIndex == index;

  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? const Color(0xFF1D5DE5) : const Color(0xFFECEFF5),
          width: 1.2,
        ),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: SvgPicture.asset(icon, width: 24, height: 24)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF151E2F),
              ),
            ),
          ),
          Icon(
            isSelected
                ? Icons.radio_button_checked
                : Icons.radio_button_off_outlined,
            color: isSelected
                ? const Color(0xFF1D5DE5)
                : const Color(0xFFDAE0EE),
          ),
        ],
      ),
    ),
  );
}
