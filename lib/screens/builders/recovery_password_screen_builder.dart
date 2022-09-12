import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:login_registration_app/screens/mobile/recovery_password_screen.dart';
import 'package:login_registration_app/screens/web/recovery_password_screen_web.dart';

class RecoveryPasswordScreenBuilder extends StatelessWidget {
  static const String route = '/recoveryPassword';

  const RecoveryPasswordScreenBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? const RecoveryPasswordScreenWeb()
        : const RecoveryPasswordScreen();
  }
}
