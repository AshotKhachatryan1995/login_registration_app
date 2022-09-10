import 'package:equatable/equatable.dart';

import '../../middleware/controllers/login_controllers.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends SignInEvent {}

class TextFieldValueChangedEvent extends SignInEvent {
  const TextFieldValueChangedEvent({required this.controllers});
  final LoginControllers controllers;

  @override
  List<Object> get props => [controllers];
}

class UserSignInEvent extends SignInEvent {
  const UserSignInEvent({required this.controllers});
  final LoginControllers controllers;

  @override
  List<Object> get props => [controllers];
}
