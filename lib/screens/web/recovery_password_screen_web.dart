import 'package:flutter/material.dart';
import 'package:login_registration_app/middleware/mixins/change_locale_mixin.dart';
import 'package:login_registration_app/screens/mobile/recovery_password_screen.dart';
import 'package:login_registration_app/shared/company_info_widget.dart';
import 'package:login_registration_app/shared/main_app_bar_widget.dart';
import '../../shared/unfocus_scaffold.dart';

class RecoveryPasswordScreenWeb extends RecoveryPasswordScreen {
  const RecoveryPasswordScreenWeb({super.key});

  @override
  RecoveryPasswordScreenWebState createState() =>
      RecoveryPasswordScreenWebState();
}

class RecoveryPasswordScreenWebState
    extends RecoveryPasswordScreenState<RecoveryPasswordScreen>
    with ChangeLocaleMixin {
  @override
  Widget build(BuildContext context) {
    return UnfocusScaffold(
      body: renderBody(),
      appBar: MainAppBarWidget(
          isWeb: true,
          selectedLocale: selectedLocale,
          onLocaleChange: onLocaleChange),
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
}
