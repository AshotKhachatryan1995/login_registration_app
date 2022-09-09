import 'package:flutter/material.dart';
import 'package:login_registration_app/shared/app_localizations/localization.dart';

import '../constants/app_colors.dart';

class MainAppBarWidget extends StatelessWidget {
  const MainAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.springWoodColor,
        child: SafeArea(
            child: Container(
                margin: const EdgeInsets.only(top: 36, bottom: 36),
                child: Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 24),
                        child: _renderLogo()),
                    _renderIdWebsite(),
                    _renderLanguageArea()
                  ],
                ))));
  }

  Widget _renderIdWebsite() {
    return Container(
      margin: const EdgeInsets.only(left: 41, right: 8),
      height: 48,
      decoration: BoxDecoration(
          color: AppColors.pampasColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
              color: AppColors.tuataraColor.withOpacity(0.1), width: 0.5)),
      child: Row(children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(11, 9, 0, 9),
            child: _renderLogo()),
        Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 15, 15),
            child: Text(
              'Go to the ID Website'.tr(),
              style: const TextStyle(color: AppColors.tuataraColor),
            ))
      ]),
    );
  }

  Widget _renderLanguageArea() {
    return Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
            color: AppColors.pampasColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                color: AppColors.tuataraColor.withOpacity(0.1), width: 0.5)),
        child: Image.asset('assets/icons/usa_icon.png'));
  }

  Widget _renderLogo() {
    return Image.asset('assets/icons/logo.png');
  }
}
