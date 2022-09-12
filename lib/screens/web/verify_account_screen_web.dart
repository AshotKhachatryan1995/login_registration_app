import 'package:flutter/material.dart';
import 'package:login_registration_app/screens/mobile/recovery_password_screen.dart';
import 'package:login_registration_app/shared/company_info_widget.dart';
import 'package:login_registration_app/shared/main_app_bar_widget.dart';
import 'package:provider/provider.dart';

import '../../middleware/notifiers/locale_change_notifier.dart';
import '../../middleware/preferances/localization_preferance.dart';
import '../../shared/unfocus_scaffold.dart';
import '../mobile/verify_account_screen.dart';

class VerifyAccountScreenWeb extends VerifyAccountScreen {
  const VerifyAccountScreenWeb({required this.username, super.key})
      : super(userName: username);

  final String username;

  @override
  VerifyAccountScreenWebState createState() => VerifyAccountScreenWebState();
}

class VerifyAccountScreenWebState
    extends VerifyAccountScreenState<VerifyAccountScreenWeb> {
  late String _selectedLocale;

  @override
  void initState() {
    super.initState();

    _selectedLocale = LocalizationPreferance.defaultLocale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return UnfocusScaffold(
      body: renderBody(),
      appBar: MainAppBarWidget(
          isWeb: true,
          selectedLocale: _selectedLocale,
          onLocaleChange: _onLocaleChange),
    );
  }

  @override
  Widget renderBody({MainAxisAlignment? mainAxisAlignment}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          child: CompanyInfoWidget(
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        Expanded(
            child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: super.renderBody(
                        mainAxisAlignment: MainAxisAlignment.center))))
      ],
    );
  }

  void _onLocaleChange(String? val) {
    Provider.of<LocaleChangeNotifer>(context, listen: false).changeLocale(val);
    if (val != null) {
      setState(() {
        _selectedLocale = val;
      });
    }
  }
}
