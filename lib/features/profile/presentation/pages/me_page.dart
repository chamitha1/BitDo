import 'package:BitOwi/core/widgets/common_appbar.dart';
import 'package:BitOwi/features/profile/presentation/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MePage extends StatelessWidget {
  MePage({super.key});

  final MeController controller = Get.isRegistered<MeController>()
      ? Get.find<MeController>()
      : Get.put(MeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: CommonAppBar(title: "MePage", onBack: () => Get.back()),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ProfileImageContainer(controller: controller),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class ProfileImageContainer extends StatelessWidget {
  final MeController controller;

  const ProfileImageContainer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Profile Image',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),

          // Avatar with camera icon
          GestureDetector(
            onTap: controller.onPickIdImage,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Obx(() {
                  return Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFF779DEF), width: 2.5),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: controller.faceUrl.value.isNotEmpty
                            ? NetworkImage(controller.faceUrl.value)
                            : const AssetImage("assets/images/home/avatar.png")
                                  as ImageProvider,
                      ),
                    ),
                  );
                }),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 15,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
