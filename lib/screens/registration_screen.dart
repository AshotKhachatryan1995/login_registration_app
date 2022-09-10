import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_registration_app/middleware/controllers/registration_controllers.dart';
import 'package:login_registration_app/middleware/repositories/api_respository_impl.dart';
import 'package:login_registration_app/shared/input_form_widget.dart';
import 'package:login_registration_app/shared/text_field_widget.dart';
import 'package:login_registration_app/shared/unfocus_scaffold.dart';

import '../blocs/registration_bloc/registration_bloc.dart';
import '../blocs/registration_bloc/registration_event.dart';
import '../blocs/registration_bloc/registration_state.dart';
import '../constants/app_colors.dart';
import '../shared/custom_button.dart';
import '../shared/loading_widget.dart';

class RegistrationScreen extends StatefulWidget {
  static const String route = '/registration';

  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late final RegistrationBloc _registrationBloc;
  final RegistrationControllers _controllers = RegistrationControllers();

  @override
  void initState() {
    super.initState();

    _registrationBloc = RegistrationBloc(ApiRepositoryImpl());
  }

  @override
  void dispose() {
    _controllers.dispose();
    _registrationBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistrationBloc>(
        create: (context) => _registrationBloc,
        child: BlocConsumer<RegistrationBloc, RegistrationState>(
            listener: _listener,
            builder: (context, state) => LoadingWidget(
                isLoading: state is LoadingState,
                child: UnfocusScaffold(body: _renderBody()))));
  }

  Widget _renderBody() {
    return SingleChildScrollView(
        child: Column(children: [
      InputFormWidget(
          formTitle: 'Create a new account',
          child: Column(
            children: [
              TextFieldWidget(
                  controller: _controllers.firstNameController,
                  hintText: 'First Name'),
              TextFieldWidget(
                  controller: _controllers.lastNameController,
                  hintText: 'Last Name'),
              TextFieldWidget(
                  controller: _controllers.emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress),
              TextFieldWidget(
                  controller: _controllers.phoneController,
                  hintText: 'Phone Number',
                  keyboardType: TextInputType.number),
              TextFieldWidget(
                  controller: _controllers.passwordController,
                  hintText: 'Password',
                  obscureText: true),
              TextFieldWidget(
                  controller: _controllers.confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true),
            ],
          )),
      _renderButtons()
    ]));
  }

  Widget _renderButtons() {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      CustomButton(buttonTitle: 'cancel', onTapButton: () {}),
      const SizedBox(width: 8),
      CustomButton(
        buttonTitle: 'create',
        onTapButton: _onSignUp,
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

extension _RegistrationScreenStateAddition on _RegistrationScreenState {
  void _onSignUp() {
    if (!_controllers.areNotEmpty) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => const AlertDialog(
              title: Text('Please fill all fields',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.red))));
      return;
    }

    _registrationBloc.add(CreateUserEvent(controllers: _controllers));
  }

  void _listener(context, state) {
    if (state is UserCreatedSuccessfullyState) {
      Navigator.pushNamed(context, '/verifyAccount');
    }

    if (state is UserAlreadyExists) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => const AlertDialog(
              title: Text('This username already exists',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.red))));
    }
  }
}
