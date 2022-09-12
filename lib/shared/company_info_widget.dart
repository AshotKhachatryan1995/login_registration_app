import 'package:flutter/material.dart';
import 'package:login_registration_app/shared/app_localizations/localization.dart';

class CompanyInfoWidget extends StatelessWidget {
  const CompanyInfoWidget(
      {this.text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      this.mainAxisAlignment,
      super.key});

  final String text;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        _renderCompanyInfo(),
        _renderCompanyDetailsInfo(text: text),
      ],
    );
  }

  Widget _renderCompanyInfo() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/logo.png'),
            const SizedBox(width: 9),
            Image.asset('assets/icons/insurance_text.png'),
          ],
        ));
  }

  Widget _renderCompanyDetailsInfo({required String text}) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Text(text.tr()));
  }
}
