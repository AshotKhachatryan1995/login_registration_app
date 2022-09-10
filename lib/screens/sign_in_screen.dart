import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_registration_app/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:login_registration_app/blocs/sign_in_bloc/sign_in_state.dart';
import 'package:login_registration_app/constants/app_colors.dart';
import 'package:login_registration_app/shared/app_localizations/localization.dart';
import 'package:login_registration_app/shared/info_button_row.dart';
import 'package:login_registration_app/shared/main_app_bar_widget.dart';
import 'package:login_registration_app/shared/horizontal_padded_widget.dart';

import '../blocs/sign_in_bloc/sign_in_event.dart';
import '../middleware/controllers/login_controllers.dart';
import '../shared/loading_widget.dart';

class SignInScreen extends StatefulWidget {
  static const String route = '/signIn';

  const SignInScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final SignInBloc _signInBloc;
  final LoginControllers _controllers = LoginControllers();

  @override
  void initState() {
    super.initState();

    _signInBloc = SignInBloc();
  }

  @override
  void dispose() {
    _signInBloc.close();
    _controllers.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>(
        create: (context) => _signInBloc,
        child: BlocConsumer<SignInBloc, SignInState>(
            listener: _listener,
            builder: (context, state) => LoadingWidget(
                isLoading: state is LoadingState,
                child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Scaffold(
                        backgroundColor: AppColors.pampasColor,
                        appBar: const PreferredSize(
                            preferredSize: Size(0, 120),
                            child: MainAppBarWidget()),
                        body: _renderBody())))));
  }

  Widget _renderBody() {
    return Column(children: [
      _renderCompanyInfo(),
      _renderCompanyDetailsInfo(),
      const SizedBox(height: 34),
      _renderSignInTitle(),
      _renderSignInForm(),
      const InfoButtonRow(
        message: 'Don’t have an account?',
        buttonTitle: 'Create',
      )
    ]);
  }

  Widget _renderCompanyInfo() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/logo.png'),
            const SizedBox(width: 9),
            Image.asset('assets/icons/insurance_text.png'),
          ],
        ));
  }

  Widget _renderCompanyDetailsInfo() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque egestas ultrices maecenas lorem massa mattis malesuada ullamcorper aliquam.'
                .tr()));
  }

  Widget _renderSignInTitle() {
    return Text(
      'Sign in to your account'.tr(),
      style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.tuataraColor),
    );
  }

  Widget _renderSignInForm() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 12,
                color: Colors.black.withOpacity(0.05))
          ]),
      child: HorizontalPaddedWidget(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 48,
            margin: const EdgeInsets.symmetric(vertical: 32),
            decoration: BoxDecoration(
                color: AppColors.pampasColor, borderRadius: borderRadius),
            child: TextFormField(),
          ),
          Container(
            height: 48,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
                color: AppColors.pampasColor, borderRadius: borderRadius),
            child: TextFormField(),
          ),
          InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, '/recoveryPasswordScreen'),
              child: Text(
                'Forgot password?'.tr(),
                style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: AppColors.tuataraColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: BoxDecoration(
                  color: AppColors.curiousBlueColor,
                  borderRadius: borderRadius,
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 2),
                        blurRadius: 8,
                        color: Colors.black.withOpacity(0.3))
                  ]),
              child: Text(
                'Sign in'.tr().toUpperCase(),
                style: const TextStyle(
                    color: AppColors.pampasColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      )),
    );
  }

  BorderRadiusGeometry? get borderRadius => BorderRadius.circular(4);
}

extension _SignInScreenStateAddition on _SignInScreenState {
  void _onChanged(String val) =>
      _signInBloc.add(TextFieldValueChangedEvent(controllers: _controllers));

  void _onSignIn(bool isActive) {
    if (!isActive) {
      return;
    }

    _signInBloc.add(UserSignInEvent(controllers: _controllers));
  }

  void _listener(context, state) {
    if (state is UserSignInSuccessfullyState) {
      Navigator.pushNamed(context, '/home');
    }
  }
}
