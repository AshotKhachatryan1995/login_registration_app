import 'package:flutter/material.dart';
import 'package:login_registration_app/constants/app_styles.dart';
import 'package:login_registration_app/shared/app_localizations/localization.dart';

import '../constants/app_colors.dart';
import 'custom_button.dart';
import 'horizontal_padded_widget.dart';

class InfoButtonRow extends StatelessWidget {
  const InfoButtonRow(
      {required this.message,
      required this.buttonTitle,
      this.decoration,
      this.onTapButton,
      super.key});

  final String message;
  final String buttonTitle;
  final BoxDecoration? decoration;
  final VoidCallback? onTapButton;

  @override
  Widget build(BuildContext context) {
    return HorizontalPaddedWidget(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        message.tr(),
        style: getStyle(
            color: AppColors.tuataraColor,
            fontSize: 16,
            fontWeight: FontWeight.w400),
      ),
      CustomButton(
        buttonTitle: buttonTitle,
        onTapButton: onTapButton,
        decoration: decoration,
      )
    ]));
  }
}
