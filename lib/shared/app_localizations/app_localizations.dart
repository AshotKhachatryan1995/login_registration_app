import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import 'asset_loader.dart';
import 'translations.dart';

class AppLocalizations {
  Translations _translations = Translations({});
  late Locale _locale;

  String? path;
  final RegExp _replaceArgRegex = RegExp(r'{}');

  AppLocalizations();

  static AppLocalizations? _instance;
  static AppLocalizations get instance =>
      _instance ?? (_instance = AppLocalizations());

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget 'of' syntax
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static Future<bool> load(
    Locale locale, {
    required AssetLoader assetLoader,
    String? path,
  }) async {
    assert(path != null);
    instance._locale = locale;
    instance.path = path;

    var localePath = instance.getLocalePath();

    if (await assetLoader.localeExists(localePath) == true) {
      var data = await assetLoader.load(localePath) ?? <String, dynamic>{};
      instance._translations = Translations(data);
      return true;
    } else {
      return false;
    }
  }

  String getLocalePath() {
    final codeLang = _locale.languageCode;
    final localePath = '$path/$codeLang';

    return '$localePath.json';
  }

  String tr(String key, {List<String>? args}) {
    return _replaceArgs(_resolve(key), args);
  }

  String _replaceArgs(String res, List<String>? args) {
    if (args == null || args.isEmpty) return res;
    for (var str in args) {
      res = res.replaceFirst(_replaceArgRegex, str);
    }
    return res;
  }

  String plural(String key, dynamic value, {NumberFormat? format}) {
    return _replaceArgs(_resolve(key), [
      format == null ? '$value' : format.format(value),
    ]);
  }

  String _resolve(String key) {
    final resource = _translations.get(key);
    if (resource == null) {
      Logger().w(
          '[easy_localization] Missing message: "$key" for locale: "${_locale.languageCode}", using key as fallback.');
      return key;
    }

    return resource;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'ru', 'hy'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    await AppLocalizations.load(
      locale,
      path: 'assets/localizations',
      assetLoader: const RootBundleAssetLoader(),
    );
    return AppLocalizations.instance;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
