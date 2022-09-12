import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:login_registration_app/middleware/preferances/localization_preferance.dart';
import 'package:login_registration_app/shared/app_localizations/localization.dart';

import '../constants/app_colors.dart';

class MainAppBarWidget extends StatefulWidget {
  const MainAppBarWidget(
      {required this.isWeb,
      required this.selectedLocale,
      required this.onLocaleChange,
      super.key});

  final bool isWeb;
  final String selectedLocale;
  final StringCallback onLocaleChange;

  @override
  State<StatefulWidget> createState() => _MainAppBarWidgetState();
}

class _MainAppBarWidgetState extends State<MainAppBarWidget> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.selectedLocale;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.springWoodColor,
        child: SafeArea(
            child: Container(
                margin: const EdgeInsets.only(top: 36, bottom: 36),
                child: Row(
                  mainAxisAlignment: widget.isWeb
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    if (!widget.isWeb)
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
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                color: AppColors.tuataraColor.withOpacity(0.1), width: 0.5)),
        child: DropdownButton2<String>(
            value: dropdownValue,
            alignment: Alignment.center,
            underline: const SizedBox(),
            onChanged: (String? val) {
              widget.onLocaleChange.call(val);
              if (val != null) {
                setState(() {
                  dropdownValue = val;
                });
              }
            },
            buttonPadding: EdgeInsets.zero,
            itemPadding: EdgeInsets.zero,
            barrierColor: Colors.black.withOpacity(0.2),
            icon: const SizedBox(),
            items: LocalizationPreferance.localies
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Image.asset(
                  value == 'en'
                      ? 'assets/icons/usa_icon.png'
                      : 'assets/icons/rus_icon.png',
                  width: 48,
                ),
              );
            }).toList()));
  }

  Widget _renderLogo() {
    return Image.asset('assets/icons/logo.png');
  }
}

typedef StringCallback = void Function(String?);
