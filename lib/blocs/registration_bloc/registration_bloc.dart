import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_registration_app/middleware/extensions/string_extension.dart';
import 'package:uuid/uuid.dart';

import '../../middleware/models/user.dart';
import '../../middleware/preferances/shared_preferance.dart';
import 'registration_event.dart';
import 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(InitialState()) {
    on<TextFieldValueChangedEvent>(_onTextFieldValueChangedEvent);
    on<CreateUserEvent>(_onCreateUserEvent);
  }

  final _sharedPrefs = SharedPrefs();

  Future<void> _onTextFieldValueChangedEvent(
      TextFieldValueChangedEvent event, Emitter<RegistrationState> emit) async {
    final controllers = event.controllers;

    final isValid = controllers.areNotEmpty;

    emit(ButtonState(isActive: isValid));
  }

  Future<void> _onCreateUserEvent(
      CreateUserEvent event, Emitter<RegistrationState> emit) async {
    emit(LoadingState());

    final controllers = event.controllers;

    final user = User(
        id: const Uuid().v4(),
        firstName: controllers.firstNameController.text,
        lastName: controllers.lastNameController.text,
        email: controllers.emailController.text,
        phone: controllers.phoneController.text,
        password: controllers.passwordController.text.generateMd5());

    try {
      final box = await Hive.openBox<User>('users_db');

      final userEmail =
          box.values.firstWhereOrNull((element) => element.email == user.email);

      final userPhone =
          box.values.firstWhereOrNull((element) => element.phone == user.phone);

      if (userPhone != null || userEmail != null) {
        emit(UserAlreadyExists());
        return;
      }

      await box.put(user.id, user);
      await _sharedPrefs.setString('userId', user.id);

      await box.close();
    } catch (e) {
      emit(UserCreateInvalidState());
      throw Exception(e.toString());
    }

    emit(UserCreatedSuccessfullyState());
  }
}
