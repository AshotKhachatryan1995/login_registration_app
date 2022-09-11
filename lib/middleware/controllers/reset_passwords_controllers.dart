import 'package:flutter/material.dart';

class ResetPasswordsControllers {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool get areNotEmpty =>
      confirmPasswordController.text.isNotEmpty &&
      passwordController.text.isNotEmpty;

  void dispose() {
    confirmPasswordController.dispose();
    passwordController.dispose();
  }
}
