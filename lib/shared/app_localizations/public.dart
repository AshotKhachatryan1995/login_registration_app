import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'app_localizations.dart';

String tr(String key, {BuildContext? context, List<String>? args}) {
  return context == null
      ? AppLocalizations.instance.tr(key, args: args)
      : AppLocalizations.of(context)?.tr(key, args: args) ?? '';
}

String plural(String key, dynamic value,
    {BuildContext? context, NumberFormat? format}) {
  return context == null
      ? AppLocalizations.instance.plural(key, value, format: format)
      : AppLocalizations.of(context)?.plural(key, value, format: format) ?? '';
}
