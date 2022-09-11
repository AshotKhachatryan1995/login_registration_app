import 'package:login_registration_app/middleware/repositories/validation_repository.dart';

class ValidationRepositoryImpl implements ValidationRepository {
  @override
  bool isValidEmail(String email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  @override
  bool isValidPassword(String password) =>
      password.length > 6 && password.length < 12;

  @override
  bool isValidPhoneNumber(String phoneNumber) =>
      phoneNumber.length > 5 && phoneNumber.length < 8;
}
