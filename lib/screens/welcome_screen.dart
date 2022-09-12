import 'package:flutter/material.dart';
import 'package:login_registration_app/constants/app_styles.dart';
import 'package:login_registration_app/shared/unfocus_scaffold.dart';
import 'package:provider/provider.dart';

import '../middleware/notifiers/user_notifier.dart';

class WelcomeScreen extends StatefulWidget {
  static const String route = '/welcome';

  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late UserNotifier _userNotifier;

  @override
  void initState() {
    super.initState();

    _userNotifier = Provider.of<UserNotifier>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return UnfocusScaffold(
      body: Align(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text('Welcome', style: getStyle(fontSize: 30)),
        const SizedBox(height: 20),
        Text(_userNotifier.user?.firstName ?? ''),
        Text(_userNotifier.user?.lastName ?? '')
      ])),
    );
  }
}
