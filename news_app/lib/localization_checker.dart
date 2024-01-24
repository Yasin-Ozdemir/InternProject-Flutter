import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationChecker {
  static turkishLanguage(BuildContext context) {
    Locale? currentLocal = EasyLocalization.of(context)!.currentLocale;
    if (currentLocal == Locale('en', 'US')) {
      EasyLocalization.of(context)!.setLocale(Locale('tr', 'TR'));
    }
  }

  static englishLanguage(BuildContext context) {
    Locale? currentLocal = EasyLocalization.of(context)!.currentLocale;
    if (currentLocal == Locale('tr', 'TR')) {
      EasyLocalization.of(context)!.setLocale(Locale('en', 'US'));
    }
  }
}
