import 'package:BitOwi/config/config.dart';

enum WebUrl { personalInfo, thirdPartyInfo }

class IMConfig {
  static const int sdkappid = int.fromEnvironment(
    'SDK_APPID',
    defaultValue: AppConfig.imAppId,
  );
  static const String key = String.fromEnvironment('KEY', defaultValue: "");
  static const String appVersion = String.fromEnvironment(
    'APP_VERSION',
    defaultValue: "0.0.1",
  );
  static const String projectType = String.fromEnvironment(
    'PROJECT_TYPE',
    defaultValue: "discord",
  );
  static const bool productEnv = bool.fromEnvironment(
    'ISPRODUCT_ENV',
    defaultValue: false,
  );
  static const bool openShareFeature = bool.fromEnvironment(
    'OPEN_SHARE_FEATURE',
    defaultValue: true,
  );
  static const String smsLoginHttpBase =
      'https://demos.trtc.tencent-cloud.com/prod';
  // static const String captchaUrl =
  // 'https://imgcache.qq.com/operation/dianshi/other/captcha.11f3ef11e3657473779f28383735c6a680a87180.html';
  static const String captchaUrl = 'https://comm.qq.com/login/captcha/app.html';
  static const String webCaptchaUrl =
      'https://comm.qq.com/login/captcha/index.html';
  static const int loglevel = 3;
  static String appName = "Tencent IM";
  static const pushConfig = <String, Map<String, double>>{
    "ios": {"dev": 30626, "prod": 30572},
  };
  // App bar tile cannot be adapted, it must be constant
  static const double appBarTitleFontSize = 17;

  static const String baiduMapIOSAppKey = "Zj9tGHMYCGyE3Q2rdk3Mh6qRGXQvG6kv";

  static const Map<WebUrl, String> webUrls = {
    WebUrl.personalInfo:
        "https://privacy.qq.com/document/preview/45ba982a1ce6493597a00f8c86b52a1e",
    WebUrl.thirdPartyInfo:
        "https://privacy.qq.com/document/preview/dea84ac4bb88454794928b77126e9246",
  };
}
