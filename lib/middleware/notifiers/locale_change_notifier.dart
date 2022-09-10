import 'package:flutter/material.dart';
import 'package:login_registration_app/middleware/preferances/localization_preferance.dart';

class LocaleChangeNotifer with ChangeNotifier {
  Locale _currentLocale = LocalizationPreferance.defaultLocale;

  Locale get currentLocale => _currentLocale;

  void changeLocale(String? locale) {
    final newLocale = locale;

    if (newLocale != null && newLocale != _currentLocale.languageCode) {
      _currentLocale = Locale(newLocale);
      notifyListeners();
    }
  }
}
