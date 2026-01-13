import 'package:BitOwi/core/widgets/common_appbar.dart';
import 'package:BitOwi/core/widgets/primary_button.dart';
import 'package:BitOwi/core/widgets/soft_circular_loader.dart';
import 'package:BitOwi/features/profile/presentation/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethodsPage extends StatelessWidget {
  PaymentMethodsPage({super.key});

  final settingsController = Get.find<SettingsController>();

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
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: buildUpdateButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUpdateButton() {
    return Obx(() {
      final isLoading = settingsController.currencyUpdating.value;
      final isChanged =
          settingsController.selectedIndex.value !=
          settingsController.savedIndex.value;

      return PrimaryButton(
        text: "Add Payment Method",
        enabled: isChanged && !isLoading,
        onPressed: settingsController.onChoseUpdate,
        child: isLoading ? const SoftCircularLoader(color: Colors.white) : null,
      );
    });
  }
}
