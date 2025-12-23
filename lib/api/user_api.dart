import 'package:dio/dio.dart';

Future<Register> register({
    required String email,
    required String smsCode,
    required String loginPwd,
    String? inviteCode,
  }) async {
    try {
      final res = await Dio.(
        '/core/v1/cuser/public/register_by_email',
        {
          'email': email,
          'smsCode': smsCode,
          'loginPwd': loginPwd,
          'inviteCode': inviteCode,
        },
      );
      return Register.fromJson(CommonUtils.removeNullKeys(res));
    } catch (e) {
      e.printError();
      rethrow;
    }
  }