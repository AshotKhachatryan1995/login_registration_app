import 'package:flutter/material.dart';
import 'package:login_registration_app/middleware/mixins/change_locale_mixin.dart';
import 'package:login_registration_app/shared/company_info_widget.dart';
import 'package:login_registration_app/shared/main_app_bar_widget.dart';

import '../../shared/unfocus_scaffold.dart';
import '../mobile/registration_screen.dart';

class RegistrationScreenWeb extends RegistrationScreen {
  const RegistrationScreenWeb({super.key});

  @override
  RegistrationScreenWebState createState() => RegistrationScreenWebState();
}

class RegistrationScreenWebState
    extends RegistrationScreenState<RegistrationScreenWeb>
    with ChangeLocaleMixin {
  @override
  Widget render() {
    return UnfocusScaffold(
      body: renderBody(),
      appBar: MainAppBarWidget(
          isWeb: true,
          selectedLocale: selectedLocale,
          onLocaleChange: onLocaleChange),
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
}
