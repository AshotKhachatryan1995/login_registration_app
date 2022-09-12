import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:login_registration_app/screens/mobile/sign_in_screen.dart';
import 'package:login_registration_app/screens/web/sign_in_screen_web.dart';

class SignInScreenBuilder extends StatelessWidget {
  static const String route = '/signIn';

  const SignInScreenBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? const SignInScreenWeb() : const SignInScreen();
  }
}
