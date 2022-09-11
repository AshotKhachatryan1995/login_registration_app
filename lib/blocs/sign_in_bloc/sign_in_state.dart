import 'package:equatable/equatable.dart';
import 'package:login_registration_app/middleware/models/user.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends SignInState {}

class LoadingState extends SignInState {}

class ButtonState extends SignInState {
  ButtonState({required this.isActive});
  final bool isActive;

  @override
  List<Object> get props => [isActive];
}

class UserSignInSuccessfullyState extends SignInState {
  UserSignInSuccessfullyState({required this.user});
  final User user;

  @override
  List<Object> get props => [user];
}

class UserSignInInvalidState extends SignInState {}
