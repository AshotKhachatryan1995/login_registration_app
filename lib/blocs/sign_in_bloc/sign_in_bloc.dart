import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_registration_app/middleware/repositories/api_respository_impl.dart';

import '../../middleware/preferances/shared_preferance.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(this._apiRepositoryImpl) : super(InitialState()) {
    on<TextFieldValueChangedEvent>(_onTextFieldValueChangedEvent);
    on<UserSignInEvent>(_onUserSignInEvent);
  }

  final _sharedPrefs = SharedPrefs();
  final ApiRepositoryImpl _apiRepositoryImpl;

  Future<void> _onTextFieldValueChangedEvent(
      TextFieldValueChangedEvent event, Emitter<SignInState> emit) async {
    final controllers = event.controllers;

    final isValid = controllers.areNotEmpty;

    emit(ButtonState(isActive: isValid));
  }

  Future<void> _onUserSignInEvent(
      UserSignInEvent event, Emitter<SignInState> emit) async {
    emit(LoadingState());

    final userName = event.controllers.userNameController.text;
    final password = event.controllers.passwordController.text;
    try {
      final result = await _apiRepositoryImpl.signIn(
          userName: userName, password: password);

      if (result == null) {
        emit(UserSignInInvalidState());
        return;
      }

      if (result is String) {
        await _sharedPrefs.setString('userId', result);

        emit(UserSignInSuccessfullyState());
        return;
      }
    } catch (e) {
      throw Exception(e.toString());
    }

    emit(UserSignInInvalidState());
  }
}
