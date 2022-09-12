import 'package:flutter/material.dart';
import 'package:login_registration_app/middleware/mixins/change_locale_mixin.dart';
import 'package:login_registration_app/shared/company_info_widget.dart';
import 'package:login_registration_app/shared/main_app_bar_widget.dart';

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
    extends VerifyAccountScreenState<VerifyAccountScreenWeb>
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
