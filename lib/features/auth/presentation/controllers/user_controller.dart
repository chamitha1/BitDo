import 'package:BitOwi/core/storage/storage_service.dart';
import 'package:BitOwi/api/user_api.dart';
import 'package:get/get.dart';
import 'package:BitOwi/models/user_model.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  final userName = 'User'.obs;
  // Expose full user object
  final Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  Future<void> loadUser() async {
    // Fetch latest user info from API
    try {
      final fetchedUser = await UserApi.getUserInfo();
      user.value = fetchedUser;

      if (fetchedUser.nickname != null && fetchedUser.nickname!.isNotEmpty) {
        setUserName(fetchedUser.nickname!);
      } else if (fetchedUser.realName != null && fetchedUser.realName!.isNotEmpty) {
        setUserName(fetchedUser.realName!);
      }
    } catch (e) {
      print('Error fetching user info: $e');
    }
  }

  Future<void> setUserName(String name) async {
    userName.value = name;
  }

  Future<void> logout() async {
    try {
      await UserApi.logOff();
      
    } catch (e) {
      print("Logout API failed: $e");
    } finally {
      // Clear data regardless of API success
      await StorageService.removeToken();
      // Navigate to login
      Get.offAllNamed('/login');
    }
  }
}
