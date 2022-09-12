import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:login_registration_app/screens/mobile/verify_account_screen.dart';
import 'package:login_registration_app/screens/web/verify_account_screen_web.dart';

class VerifyAccountScreenBuilder extends StatelessWidget {
  static const String route = '/verifyAccount';

  const VerifyAccountScreenBuilder({required this.userName, super.key});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? VerifyAccountScreenWeb(username: userName)
        : VerifyAccountScreen(userName: userName);
  }
}
