import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:login_registration_app/screens/mobile/registration_screen.dart';
import 'package:login_registration_app/screens/web/registration_screen_web.dart';

class RegistrationScreenBuilder extends StatelessWidget {
  static const String route = '/registration';

  const RegistrationScreenBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? const RegistrationScreenWeb() : const RegistrationScreen();
  }
}
