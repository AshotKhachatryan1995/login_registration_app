import 'package:flutter/material.dart';
import 'package:login_registration_app/constants/app_colors.dart';
import 'package:login_registration_app/shared/custom_divider.dart';
import 'package:login_registration_app/shared/detail_app_bar_widget.dart';
import 'package:login_registration_app/shared/info_button_row.dart';

import '../shared/input_form_widget.dart';

class RecoveryPasswordScreen extends StatefulWidget {
  const RecoveryPasswordScreen({super.key});

  @override
  State<RecoveryPasswordScreen> createState() => _RecoveryPasswordScreenState();
}

class _RecoveryPasswordScreenState extends State<RecoveryPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pampasColor,
      appBar: const PreferredSize(
          preferredSize: Size(0, 120), child: DetailAppBarWidget()),
      body: _renderBody(),
    );
  }

  Widget _renderBody() {
    return Column(
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
          formTitle: 'Recover your password',
          child: Column(
            children: [
              const SizedBox(height: 32),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Text(
                    'Please, enter your username, phone number, email or ID number to search for your account',
                    style: TextStyle(
                        color: AppColors.tuataraColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )),
              const CustomDivider(),
              Container(
                height: 48,
                margin: const EdgeInsets.symmetric(vertical: 32),
                decoration: BoxDecoration(
                    color: AppColors.pampasColor,
                    borderRadius: BorderRadius.circular(4)),
                child: TextFormField(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
