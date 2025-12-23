import 'package:BitDo/config/api_client.dart';
import 'package:BitDo/features/auth/presentation/pages/login_screen.dart';
import 'package:BitDo/features/auth/presentation/pages/signup_screen.dart';
import 'package:dio/dio.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';

// Future<Map<String, dynamic>> sendOtp(String email) async {
//   try {
//     final res = await ApiClient.dio.post(
//       '/cuser/public/send_email_code',
//       data: {
//         'email': email,
//         'type': 'register',
//       },
//     );
//     return res.data;
//   } catch (e) {
//     print(e);
//     rethrow;
//   }
// }

Future<LoginScreen> login({
  required String loginName,
  required String loginPwd,
}) async {
  try {
    final response = await ApiClient.dio.post(
      '/cuser/public/login',
      data: {'loginName': loginName, 'loginPwd': loginPwd},
    );
    return response.data;
  } catch (e) {
    e.printError();
    rethrow;
  }
}

Future<Map<String, dynamic>> signup({
  required String email,
  required String smsCode,
  required String loginPwd,
  String? inviteCode,
}) async {
  try {
    final Map<String, dynamic> data = {
      'email': email,
      'smsCode': smsCode,
      'loginPwd': loginPwd,
    };

    if (inviteCode != null && inviteCode.isNotEmpty) {
      data['inviteCode'] = inviteCode;
    }

    final response = await ApiClient.dio.post(
      '/cuser/public/register_by_email',
      data: data,
    );
    return response.data as Map<String, dynamic>;
  } catch (e) {
    print(e);
    rethrow;
  }
}

// Future<LoginScreen> login({
//   required String loginName,
//   required String loginPwd,
// }) async {
//   try {
//     final res = await HttpUtil.post('/cuser/public/login', {
//       'loginName': loginName,
//       'loginPwd': loginPwd,
//     });
//     return login.fromJson(CommonUtils.removeNullKeys(res));
//   } catch (e) {
//     e.printError();
//     rethrow;
//   }
// }
