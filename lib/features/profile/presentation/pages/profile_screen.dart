import 'package:BitOwi/features/auth/presentation/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FF),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            _buildHeader(userController),

            const Spacer(),

            // Action Buttons Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Log Out Button
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => userController.logout(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Color(0xFF1D5DE5), width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: const Color(0xffF6F9FF),
                      ),
                      child: const Text(
                        "Log Out",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xFF1D5DE5),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Delete Account Button
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () =>
                          _showDeleteConfirmDialog(context, userController),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Delete Account",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(UserController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF1D5DE5).withOpacity(0.2),
                width: 2,
              ),
            ),
            child: Obx(() {
              final avatarUrl = controller.user.value?.avatar;
              return CircleAvatar(
                radius: 32, // Adjusted size for Row layout
                backgroundColor: const Color(0xFFF0F4FF),
                backgroundImage: (avatarUrl != null && avatarUrl.isNotEmpty)
                    ? NetworkImage(avatarUrl)
                    : null,
                child: (avatarUrl == null || avatarUrl.isEmpty)
                    ? const Icon(Icons.person,
                        size: 32, color: Color(0xFF1D5DE5))
                    : null,
              );
            }),
          ),
          const SizedBox(width: 16),
          
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  final name = controller.user.value?.nickname ?? 
                               controller.userName.value;
                  return Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      color: Color(0XFF151E2F),
                    ),
                  );
                }),
                const SizedBox(height: 4),
                // Email
                Obx(() {
                  final email = controller.user.value?.email ?? '';
                  if (email.isEmpty) return const SizedBox.shrink();
                  return Text(
                    email,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      color: Color(0XFF717F9A),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmDialog(
      BuildContext context, UserController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Confirm Delete",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF151E2F),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Confirm if you want to delete account?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF454F63),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(), // Close
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child:
                        const Text("No", style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      controller.logout(); // Reuse logout for now
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Yes",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
