import 'package:flutter/material.dart';
import 'package:login_registration_app/shared/custom_divider.dart';
import 'package:login_registration_app/shared/info_button_row.dart';
import 'package:login_registration_app/shared/input_form_widget.dart';
import 'package:login_registration_app/shared/text_field_widget.dart';
import 'package:login_registration_app/shared/unfocus_scaffold.dart';

import '../constants/app_colors.dart';

class VerifyAccountScreen extends StatefulWidget {
  static const String route = '/verifyAccount';

  const VerifyAccountScreen({super.key});

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return UnfocusScaffold(body: _renderBody());
  }

  Widget _renderBody() {
    return InputFormWidget(
        formTitle: 'Account verification',
        child: Column(children: [
          const SizedBox(height: 32),
          const Text(
            'A verification code has been sent to your email account to complete your registration process. Please check your email.',
            style: TextStyle(
                color: AppColors.tuataraColor,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 14),
          const CustomDivider(),
          TextFieldWidget(
            controller: TextEditingController(),
            hintText: 'Verification code',
            textAlign: TextAlign.center,
          ),
          const InfoButtonRow(
              message: 'Haven’t recieced yet?', buttonTitle: 'Resend')
        ]));
  }
}
