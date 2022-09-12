import 'package:flutter/material.dart';
import 'package:login_registration_app/screens/mobile/recovery_password_screen.dart';
import 'package:login_registration_app/shared/company_info_widget.dart';
import 'package:login_registration_app/shared/main_app_bar_widget.dart';
import 'package:provider/provider.dart';

import '../../middleware/notifiers/locale_change_notifier.dart';
import '../../middleware/preferances/localization_preferance.dart';
import '../../shared/unfocus_scaffold.dart';

class RecoveryPasswordScreenWeb extends RecoveryPasswordScreen {
  const RecoveryPasswordScreenWeb({super.key});

  @override
  RecoveryPasswordScreenWebState createState() =>
      RecoveryPasswordScreenWebState();
}

class RecoveryPasswordScreenWebState
    extends RecoveryPasswordScreenState<RecoveryPasswordScreen> {
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
  Widget renderSignInArea() {
    return const SizedBox();
  }

  @override
  Widget renderBody() {
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
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          renderInputArea(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end),
                          renderButtons()
                        ]))))
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
