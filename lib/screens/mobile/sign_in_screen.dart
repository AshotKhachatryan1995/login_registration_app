import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_registration_app/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:login_registration_app/blocs/sign_in_bloc/sign_in_state.dart';
import 'package:login_registration_app/constants/app_colors.dart';
import 'package:login_registration_app/constants/app_styles.dart';
import 'package:login_registration_app/middleware/mixins/change_locale_mixin.dart';
import 'package:login_registration_app/middleware/repositories/api_respository_impl.dart';
import 'package:login_registration_app/shared/app_localizations/localization.dart';
import 'package:login_registration_app/shared/company_info_widget.dart';
import 'package:login_registration_app/shared/info_button_row.dart';
import 'package:login_registration_app/shared/main_app_bar_widget.dart';
import 'package:login_registration_app/shared/text_field_widget.dart';
import 'package:provider/provider.dart';

import '../../blocs/sign_in_bloc/sign_in_event.dart';
import '../../middleware/controllers/login_controllers.dart';
import '../../middleware/notifiers/user_notifier.dart';
import '../../shared/input_form_widget.dart';
import '../../shared/loading_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<StatefulWidget> createState() => SignInScreenState();
}

class SignInScreenState<T extends SignInScreen> extends State<T>
    with ChangeLocaleMixin {
  late final SignInBloc _signInBloc;
  final LoginControllers _controllers = LoginControllers();

  @override
  void initState() {
    super.initState();

    _signInBloc = SignInBloc(ApiRepositoryImpl());
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
                        appBar: PreferredSize(
                            preferredSize: const Size(0, 120),
                            child: renderAppBar()),
                        body: renderBody())))));
  }

  Widget renderAppBar({bool isWeb = false}) {
    return MainAppBarWidget(
        isWeb: isWeb,
        selectedLocale: selectedLocale,
        onLocaleChange: onLocaleChange);
  }

  Widget renderBody() {
    return SingleChildScrollView(
        child: Column(children: [
      renderCompanyArea(),
      const SizedBox(height: 34),
      renderForm(),
      renderCreateAccountRow()
    ]));
  }

  Widget renderCompanyArea(
      {MainAxisAlignment? mainAxisAlignment,
      String text =
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque egestas ultrices maecenas lorem massa mattis malesuada ullamcorper aliquam.'}) {
    return CompanyInfoWidget(
      text: text,
      mainAxisAlignment: mainAxisAlignment,
    );
  }

  Widget renderForm(
      {MainAxisAlignment? mainAxisAlignment,
      CrossAxisAlignment? crossAxisAlignment}) {
    return InputFormWidget(
      formTitle: 'Sign in to your account',
      mainAxisAlignment: mainAxisAlignment,
      child: Column(
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          children: [
            TextFieldWidget(
                controller: _controllers.userNameController,
                onChanged: _onChanged,
                hintText: 'Username'),
            TextFieldWidget(
                controller: _controllers.passwordController,
                obscureText: true,
                onChanged: _onChanged,
                hintText: 'Password'),
            InkWell(
                onTap: () => Navigator.pushNamed(context, '/recoveryPassword'),
                child: Text(
                  'Forgot password?'.tr(),
                  style: insuranceDefaultStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w400),
                )),
            _renderSignInButton()
          ]),
    );
  }

  Widget renderCreateAccountRow() {
    return InfoButtonRow(
      message: 'Don???t have an account?',
      buttonTitle: 'Create',
      onTapButton: () => Navigator.pushNamed(context, '/registration'),
    );
  }

  Widget _renderSignInButton() {
    return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      final isActive = (state is ButtonState) ? state.isActive : false;

      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: BoxDecoration(
                  color: isActive ? AppColors.curiousBlueColor : Colors.white,
                  borderRadius: borderRadius,
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 2),
                        blurRadius: 8,
                        color: Colors.black.withOpacity(0.3))
                  ]),
              child: InkWell(
                  onTap: () => _onSignIn(isActive),
                  child: Text(
                    'Sign in'.tr().toUpperCase(),
                    style: getStyle(
                        color: isActive
                            ? AppColors.pampasColor
                            : AppColors.curiousBlueColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ))));
    });
  }

  BorderRadiusGeometry? get borderRadius => BorderRadius.circular(4);
}

extension SignInScreenStateAddition on SignInScreenState {
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
      Provider.of<UserNotifier>(context, listen: false)
          .setNewUser(user: state.user);

      Navigator.pushNamed(context, '/welcome');
    }
  }
}
