import 'package:flutter/material.dart';
import 'package:login_registration_app/screens/mobile/sign_in_screen.dart';

class SignInScreenWeb extends SignInScreen {
  const SignInScreenWeb({super.key});

  @override
  SignInScreenWebState createState() => SignInScreenWebState();
}

class SignInScreenWebState extends SignInScreenState<SignInScreenWeb> {
  @override
  Widget renderAppBar({bool isWeb = false}) {
    return super.renderAppBar(isWeb: true);
  }

  @override
  Widget renderBody() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: renderCompanyArea(
              mainAxisAlignment: MainAxisAlignment.center,
              text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
        ),
        Expanded(
            child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: renderForm(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end))))
      ],
    );
  }
}
