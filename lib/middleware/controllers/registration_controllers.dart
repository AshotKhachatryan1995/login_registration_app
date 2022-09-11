import 'package:flutter/material.dart';
import 'package:login_registration_app/middleware/models/country.dart';
import 'package:login_registration_app/shared/countries/country_loader.dart';

class RegistrationControllers {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Country? selectedCountry = CountryLoader.instance.defaultCountry;

  bool get areNotEmpty =>
      firstNameController.text.isNotEmpty &&
      lastNameController.text.isNotEmpty &&
      emailController.text.isNotEmpty &&
      phoneController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      confirmPasswordController.text.isNotEmpty;

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
