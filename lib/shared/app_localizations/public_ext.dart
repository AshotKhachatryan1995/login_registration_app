import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'public.dart' as ez;

extension TextTranslateExtension on Text {
  Text tr({BuildContext? context, List<String>? args}) =>
      Text(ez.tr(data!, context: context, args: args),
          key: key,
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis);
  Text plural(dynamic value,
          {BuildContext? context, intl.NumberFormat? format}) =>
      Text(ez.plural(data!, value, context: context, format: format),
          key: key,
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis);
}

extension StringTranslateExtension on String {
  String tr({List<String> args = const <String>[]}) => ez.tr(this, args: args);
  String plural(dynamic value, {intl.NumberFormat? format}) =>
      ez.plural(this, value, format: format);
}
