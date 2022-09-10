import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_registration_app/middleware/extensions/string_extension.dart';

import '../../middleware/models/user.dart';
import '../../middleware/preferances/shared_preferance.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(InitialState()) {
    on<TextFieldValueChangedEvent>(_onTextFieldValueChangedEvent);
    on<UserSignInEvent>(_onUserSignInEvent);
  }

  final _sharedPrefs = SharedPrefs();

  Future<void> _onTextFieldValueChangedEvent(
      TextFieldValueChangedEvent event, Emitter<SignInState> emit) async {
    final controllers = event.controllers;

    final isValid = controllers.areNotEmpty;

    emit(ButtonState(isActive: isValid));
  }

  Future<void> _onUserSignInEvent(
      UserSignInEvent event, Emitter<SignInState> emit) async {
    emit(LoadingState());
    final box = await Hive.openBox<User>('users_db');

    final userName = event.controllers.userNameController.text;
    final password = event.controllers.passwordController.text;
    final users = box.values
        .where((user) => user.email == userName || user.phone == userName)
        .toList();

    if (users.isEmpty) {
      emit(UserSignInInvalidState());
      return;
    }

    final user = users.first;

    if (user.password == password.generateMd5()) {
      await _sharedPrefs.setString('userId', user.id);

      emit(UserSignInSuccessfullyState());
      return;
    }

    emit(UserSignInInvalidState());
  }
}
