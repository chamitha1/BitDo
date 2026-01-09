import 'package:BitOwi/config/routes.dart';
import 'package:BitOwi/core/widgets/common_appbar.dart';
import 'package:BitOwi/features/profile/presentation/pages/change_email_page.dart';
import 'package:BitOwi/features/profile/presentation/pages/me_page.dart';
import 'package:BitOwi/features/profile/presentation/widgets/profile_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: CommonAppBar(title: "Settings", onBack: () => Get.back()),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Menu Items
            ProfileGroupCard(
              children: [
                ProfileMenuItem(
                  iconPath: 'assets/icons/profile_page/user_tag.svg',
                  title: "Me",
                  subtitle: "Your profile information",
                  onTap: () => Get.toNamed(Routes.mePage),
                ),
                const _Divider(),
                ProfileMenuItem(
                  iconPath: 'assets/icons/profile_page/dollar_circle.svg',
                  title: "Local Currency",
                  subtitle: "Set your preferred currency",
                  onTap: () => Get.toNamed(Routes.mePage),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, color: Color(0xFFF0F4FF));
  }
}
