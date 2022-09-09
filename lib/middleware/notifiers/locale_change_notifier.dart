import 'package:flutter/material.dart';

class LocaleChangeNotifer with ChangeNotifier {
  Locale _currentLocale = const Locale('en');

  Locale get currentLocale => _currentLocale;

  void changeLocale(String locale) {
    _currentLocale = Locale(locale);
    notifyListeners();
  }
}
