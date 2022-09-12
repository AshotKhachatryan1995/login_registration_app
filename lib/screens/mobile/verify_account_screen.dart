import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_registration_app/blocs/verify_account_bloc/verify_account_bloc.dart';
import 'package:login_registration_app/blocs/verify_account_bloc/verify_account_state.dart';
import 'package:login_registration_app/constants/app_styles.dart';
import 'package:login_registration_app/middleware/enums/user_registration_field_error_type.dart';
import 'package:login_registration_app/middleware/repositories/api_respository_impl.dart';
import 'package:login_registration_app/middleware/repositories/validation_repository_impl.dart';
import 'package:login_registration_app/shared/custom_button.dart';
import 'package:login_registration_app/shared/custom_divider.dart';
import 'package:login_registration_app/shared/info_button_row.dart';
import 'package:login_registration_app/shared/input_form_widget.dart';
import 'package:login_registration_app/shared/text_field_widget.dart';
import 'package:login_registration_app/shared/unfocus_scaffold.dart';
import 'package:provider/provider.dart';

import '../../blocs/verify_account_bloc/verify_account_event.dart';
import '../../constants/app_colors.dart';
import '../../middleware/controllers/reset_passwords_controllers.dart';
import '../../middleware/notifiers/user_notifier.dart';
import '../../shared/loading_widget.dart';

class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({required this.userName, super.key});

  final String userName;

  @override
  State<VerifyAccountScreen> createState() => VerifyAccountScreenState();
}

class VerifyAccountScreenState<T extends VerifyAccountScreen> extends State<T> {
  late final VerifyAccountBloc _verifyAccountBloc;
  final ResetPasswordsControllers _resetPasswordsControllers =
      ResetPasswordsControllers();

  final TextEditingController _codeVerificationController =
      TextEditingController();

  final ValueNotifier<bool> _accountVerifiedNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _verifyAccountBloc =
        VerifyAccountBloc(ApiRepositoryImpl(), ValidationRepositoryImpl());
    _codeVerificationController.addListener(_listener);
  }

  @override
  void dispose() {
    _verifyAccountBloc.close();
    _codeVerificationController.removeListener(_listener);
    _codeVerificationController.dispose();
    _accountVerifiedNotifier.dispose();
    _resetPasswordsControllers.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VerifyAccountBloc>(
        create: (context) => _verifyAccountBloc,
        child: BlocConsumer<VerifyAccountBloc, VerifyAccountState>(
            listener: _blocListener,
            builder: (context, state) => LoadingWidget(
                isLoading: state is LoadingState,
                child: UnfocusScaffold(body: renderBody()))));
  }

  Widget renderBody({MainAxisAlignment? mainAxisAlignment}) {
    return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: InputFormWidget(
            formTitle: 'Account verification',
            mainAxisAlignment: mainAxisAlignment,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 32),
              Text(
                'A verification code has been sent to your email account to complete your registration process. Please check your email.',
                style: insuranceDefaultStyle(fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 14),
              const CustomDivider(),
              ValueListenableBuilder(
                  valueListenable: _accountVerifiedNotifier,
                  builder: (context, bool verified, child) => TextFieldWidget(
                        controller: _codeVerificationController,
                        hintText: 'Verification code',
                        textAlign: TextAlign.center,
                        readOnly: verified,
                      )),
              InfoButtonRow(
                message: 'Haven’t recieced yet?',
                buttonTitle: 'Resend',
                onTapButton: () => _verifyAccountBloc.add(ResendCodeEvent()),
              ),
              const SizedBox(height: 16),
              _renderChangePasswordArea()
            ])));
  }

  Widget _renderChangePasswordArea() {
    return ValueListenableBuilder(
        valueListenable: _accountVerifiedNotifier,
        builder: (context, bool verified, child) => AbsorbPointer(
            absorbing: !verified,
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Change your password',
                          style: getStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )),
                    const SizedBox(height: 14),
                    const CustomDivider(),
                    TextFieldWidget(
                        controller:
                            _resetPasswordsControllers.passwordController,
                        hintText: 'New Password'),
                    TextFieldWidget(
                        controller: _resetPasswordsControllers
                            .confirmPasswordController,
                        hintText: 'Confirm Password'),
                    Align(
                        alignment: Alignment.centerRight,
                        child: CustomButton(
                          buttonTitle: 'Done',
                          titleColor: Colors.white,
                          onTapButton: _onDone,
                          decoration: BoxDecoration(
                              color: AppColors.tuataraColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4)),
                        )),
                  ],
                ))));
  }
}

extension VerifyAccountScreenStateAddition on VerifyAccountScreenState {
  void _listener() {
    final code = _codeVerificationController.text;

    if (code.length == 5) {
      _verifyAccountBloc.add(VerifyCodeEvent(code: code));
    }
  }

  void _blocListener(context, state) {
    if (state is VerifyAccountInvalidState) {
      _codeVerificationController.clear();

      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => AlertDialog(
              title: Text('Verification Code Invalid',
                  textAlign: TextAlign.center, style: errorStyle)));
    }

    if (state is SetPasswordInvalidState) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => AlertDialog(
              title: Text(state.errorType.dialogMessage(),
                  textAlign: TextAlign.center, style: errorStyle)));
    }

    if (state is PasswordUpdateInvalidState) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => AlertDialog(
              title: Text('Please try again',
                  textAlign: TextAlign.center, style: errorStyle)));
    }

    if (state is PasswordSuccessfullyUpdatedState) {
      Provider.of<UserNotifier>(context, listen: false)
          .setNewUser(user: state.user);

      Navigator.pushNamed(context, '/welcome');
    }

    if (state is VerifyAccountSuccessedState) {
      _accountVerifiedNotifier.value = true;
    }
  }

  void _onDone() {
    _verifyAccountBloc.add(SetNewPasswordEvent(
        controllers: _resetPasswordsControllers, userName: widget.userName));
  }
}
