import 'package:equatable/equatable.dart';
import 'package:login_registration_app/middleware/models/user.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object?> get props => [];
}

class InitialState extends NavigationState {}

class LoadingState extends NavigationState {}

class AuthenticatedState extends NavigationState {
  const AuthenticatedState({required this.user});
  final User user;

  @override
  List<Object?> get props => [user];
}

class UnAuthenticatedState extends NavigationState {}
