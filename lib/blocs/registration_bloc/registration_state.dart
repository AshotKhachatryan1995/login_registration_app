import 'package:equatable/equatable.dart';

import '../../middleware/enums/user_registration_field_error_type.dart';
import '../../middleware/models/user.dart';

abstract class RegistrationState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends RegistrationState {}

class LoadingState extends RegistrationState {}

class CreateNewUserState extends RegistrationState {
  CreateNewUserState({required this.user});
  final User user;

  @override
  List<Object> get props => [user];
}

class UserCreatedSuccessfullyState extends RegistrationState {}

class UserCreateInvalidState extends RegistrationState {}

class UserAlreadyExists extends RegistrationState {}

class UserFieldsAreEmptyState extends RegistrationState {}

class UserPasswordsNotMatchedState extends RegistrationState {}

class UserFieldNotValidState extends RegistrationState {
  UserFieldNotValidState({required this.errorType});
  final UserRegistrationFieldErrorType errorType;

  @override
  List<Object> get props => [errorType];
}
