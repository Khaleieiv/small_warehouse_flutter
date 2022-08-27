import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';

class Localization {
  static Locale? getNextLocale(BuildContext context) {
    String lang = EzLocalization.of(context)!.locale.languageCode;
    switch (lang) {
      case 'en':
        return const Locale('ua');
      case 'ua':
        return const Locale('en');
    }
    return null;
  }
}