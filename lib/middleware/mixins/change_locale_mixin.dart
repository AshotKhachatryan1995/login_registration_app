import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifiers/locale_change_notifier.dart';
import '../preferances/localization_preferance.dart';

mixin ChangeLocaleMixin<T extends StatefulWidget> on State<T> {
  String _selectedLocale = LocalizationPreferance.defaultLocale.languageCode;
  String get selectedLocale => _selectedLocale;

  void onLocaleChange(String? val) {
    Provider.of<LocaleChangeNotifer>(context, listen: false).changeLocale(val);
    if (val != null) {
      setState(() {
        _selectedLocale = val;
      });
    }
  }
}
