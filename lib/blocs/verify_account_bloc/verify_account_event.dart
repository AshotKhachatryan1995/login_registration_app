import 'package:equatable/equatable.dart';
import 'package:login_registration_app/middleware/controllers/reset_passwords_controllers.dart';

abstract class VerifyAccountEvent extends Equatable {
  const VerifyAccountEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends VerifyAccountEvent {}

class VerifyCodeEvent extends VerifyAccountEvent {
  const VerifyCodeEvent({required this.code});
  final String code;

  @override
  List<Object> get props => [code];
}

class SetNewPasswordEvent extends VerifyAccountEvent {
  const SetNewPasswordEvent(
      {required this.controllers, required this.userName});
  final ResetPasswordsControllers controllers;
  final String userName;

  @override
  List<Object> get props => [controllers, userName];
}

class ResendCodeEvent extends VerifyAccountEvent {}
