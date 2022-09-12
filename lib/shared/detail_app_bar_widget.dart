import 'package:flutter/material.dart';
import 'package:login_registration_app/constants/app_styles.dart';
import 'package:login_registration_app/shared/app_localizations/localization.dart';
import 'package:login_registration_app/shared/custom_divider.dart';

import '../constants/app_colors.dart';

class DetailAppBarWidget extends StatelessWidget {
  const DetailAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.springWoodColor,
        child: SafeArea(
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _renderLogo(),
                    const SizedBox(height: 10),
                    _renderDetailsInfo(),
                    const SizedBox(height: 8),
                    const CustomDivider()
                  ],
                ))));
  }

  Widget _renderDetailsInfo() {
    return Text(
      'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint.  ...'
          .tr(),
      style: insuranceDefaultStyle(),
    );
  }

  Widget _renderLogo() {
    return Image.asset('assets/icons/logo.png');
  }
}
