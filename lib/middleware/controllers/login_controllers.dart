import 'package:flutter/material.dart';

class LoginControllers {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool get areNotEmpty =>
      userNameController.text.isNotEmpty && passwordController.text.isNotEmpty;

  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
  }
}
