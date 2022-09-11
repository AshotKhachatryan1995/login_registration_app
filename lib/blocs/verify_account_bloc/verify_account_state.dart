import 'package:equatable/equatable.dart';
import 'package:login_registration_app/middleware/enums/user_registration_field_error_type.dart';
import 'package:login_registration_app/middleware/models/user.dart';

abstract class VerifyAccountState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends VerifyAccountState {}

class LoadingState extends VerifyAccountState {}

class VerifyAccountSuccessedState extends VerifyAccountState {}

class VerifyAccountInvalidState extends VerifyAccountState {}

class SetPasswordInvalidState extends VerifyAccountState {
  SetPasswordInvalidState({required this.errorType});
  final UserRegistrationFieldErrorType errorType;

  @override
  List<Object> get props => [errorType];
}

class PasswordSuccessfullyUpdatedState extends VerifyAccountState {
  PasswordSuccessfullyUpdatedState({required this.user});
  final User user;

  @override
  List<Object> get props => [user];
}

class PasswordUpdateInvalidState extends VerifyAccountState {}
