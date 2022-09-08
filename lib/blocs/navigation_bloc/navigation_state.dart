import 'package:equatable/equatable.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object?> get props => [];
}

class InitialState extends NavigationState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends NavigationState {
  @override
  List<Object?> get props => [];
}

class AuthenticatedState extends NavigationState {
  @override
  List<Object?> get props => [];
}

class UnAuthenticatedState extends NavigationState {
  @override
  List<Object?> get props => [];
}
