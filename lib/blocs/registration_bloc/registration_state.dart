import 'package:equatable/equatable.dart';

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
