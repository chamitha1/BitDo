import 'package:BitOwi/config/api_client.dart';
import 'package:get/get_utils/get_utils.dart';

/// Tencent IM interface
class IMApi {
  /// Im signature
  static Future<String> getSign() async {
    try {
      final res = await ApiClient.dio.post('/core/v1/common/getUserSig');
      return res.data['data'];
    } catch (e) {
      e.printError();
      rethrow;
    }
  }
}
