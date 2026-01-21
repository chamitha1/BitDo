import 'package:BitOwi/core/widgets/app_text.dart';
import 'package:BitOwi/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CommonBottomSheets {
  static Future<int?> showPaymentMethodBottomSheet() async {
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag handle
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB9C6E2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 24),
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

  static Widget _paymentOption({
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
            color: isSelected
                ? const Color(0xFF1D5DE5)
                : const Color(0xFFECEFF5),
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
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: SvgPicture.asset(icon, width: 24, height: 24),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(child: AppText.p2Medium(title, color: Color(0xFF151E2F))),
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
}
