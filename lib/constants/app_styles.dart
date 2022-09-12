library appstyles;

import 'package:flutter/material.dart';

import 'app_colors.dart';

const defaultFontFamily = 'Assistant';

TextStyle getStyle(
        {double? fontSize,
        FontWeight? fontWeight,
        Color? color,
        TextDecoration? decoration}) =>
    TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        decoration: decoration,
        fontFamily: defaultFontFamily);

TextStyle get errorStyle => getStyle(fontSize: 20, color: Colors.red);

TextStyle insuranceDefaultStyle(
        {FontWeight? fontWeight = FontWeight.w600,
        TextDecoration? decoration}) =>
    getStyle(
        color: AppColors.tuataraColor,
        fontSize: 16,
        fontWeight: fontWeight,
        decoration: decoration);
