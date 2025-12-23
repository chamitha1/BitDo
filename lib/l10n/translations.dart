import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'translations/en_us.dart';
import 'translations/zh_cn.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'zh_CN': zhCN,
      };

  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('zh', 'CN'),
  ];

  static const fallbackLocale = Locale('en', 'US');
}
