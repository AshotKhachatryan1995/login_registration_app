import 'package:equatable/equatable.dart';

import '../../middleware/controllers/registration_controllers.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends RegistrationEvent {}

class CreateUserEvent extends RegistrationEvent {
  const CreateUserEvent({required this.controllers});
  final RegistrationControllers controllers;

  @override
  List<Object> get props => [controllers];
}
