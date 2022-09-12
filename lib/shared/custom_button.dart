import 'package:flutter/material.dart';
import 'package:login_registration_app/constants/app_styles.dart';
import 'package:login_registration_app/shared/app_localizations/localization.dart';

import '../constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {required this.buttonTitle,
      this.titleColor,
      this.decoration,
      this.onTapButton,
      super.key});

  final String buttonTitle;
  final Color? titleColor;
  final BoxDecoration? decoration;
  final VoidCallback? onTapButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTapButton,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: decoration ??
              BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(4)),
          child: Text(
            buttonTitle.tr().toUpperCase(),
            style: getStyle(
                color: titleColor ?? AppColors.curiousBlueColor,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
        ));
  }
}
