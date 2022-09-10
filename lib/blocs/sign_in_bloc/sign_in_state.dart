import 'package:equatable/equatable.dart';

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

class UserSignInSuccessfullyState extends SignInState {}

class UserSignInInvalidState extends SignInState {}
