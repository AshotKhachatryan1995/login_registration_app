import 'package:flutter/material.dart';
import 'package:login_registration_app/constants/app_colors.dart';
import 'package:login_registration_app/shared/app_localizations/localization.dart';
import 'package:login_registration_app/shared/custom_divider.dart';
import 'package:login_registration_app/shared/info_button_row.dart';
import 'package:login_registration_app/shared/unfocus_scaffold.dart';

import '../shared/custom_button.dart';
import '../shared/input_form_widget.dart';
import '../shared/text_field_widget.dart';

class RecoveryPasswordScreen extends StatefulWidget {
  static const String route = '/recoveryPassword';

  const RecoveryPasswordScreen({super.key});

  @override
  State<RecoveryPasswordScreen> createState() => _RecoveryPasswordScreenState();
}

class _RecoveryPasswordScreenState extends State<RecoveryPasswordScreen> {
  final TextEditingController _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return UnfocusScaffold(body: _renderBody());
  }

  Widget _renderBody() {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
            color: AppColors.springWoodColor,
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: InfoButtonRow(
              message: 'Back to login ID',
              buttonTitle: 'Sign in',
              decoration: BoxDecoration(
                  color: AppColors.pampasColor,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.15))
                  ]),
            )),
        InputFormWidget(
          formTitle: 'Recover your password'.tr(),
          child: Column(
            children: [
              const SizedBox(height: 32),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Text(
                    'Please, enter your username, phone number, email or ID number to search for your account'
                        .tr(),
                    style: const TextStyle(
                        color: AppColors.tuataraColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )),
              const CustomDivider(),
              TextFieldWidget(
                  controller: _userNameController, hintText: 'Username'),
              const SizedBox(height: 16),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _renderButtons()
      ],
    ));
  }

  Widget _renderButtons() {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      CustomButton(
          buttonTitle: 'cancel', onTapButton: () => Navigator.pop(context)),
      const SizedBox(width: 8),
      CustomButton(
        buttonTitle: 'recover',
        onTapButton: _onRecover,
        titleColor: Colors.white,
        decoration: BoxDecoration(
          color: AppColors.curiousBlueColor,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 8,
                color: Colors.black.withOpacity(0.3))
          ],
        ),
      ),
      const SizedBox(width: 16),
    ]);
  }
}

extension _RecoveryPasswordScreenStateAddition on _RecoveryPasswordScreenState {
  void _onRecover() {
    if (_userNameController.text.isEmpty) {
      return;
    }

    Navigator.pushNamed(context, '/verifyAccount',
        arguments: _userNameController.text);
  }
}
