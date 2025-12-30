import 'package:BitOwi/core/storage/storage_service.dart';
import 'package:BitOwi/api/user_api.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  final userName = 'User'.obs;

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  Future<void> loadUser() async {
    // Fetch latest user info from API
    try {
      final user = await UserApi.getUserInfo();

      if (user.nickname != null && user.nickname!.isNotEmpty) {
        setUserName(user.nickname!);
      } else if (user.realName != null && user.realName!.isNotEmpty) {
        setUserName(user.realName!);
      }
      // else if (user.loginName != null && user.loginName!.isNotEmpty) {
      //   setUserName(user.loginName!);
      // }
    } catch (e) {
      print('Error fetching user info: $e');
    }
  }

  Future<void> setUserName(String name) async {
    userName.value = name;
  }
}
