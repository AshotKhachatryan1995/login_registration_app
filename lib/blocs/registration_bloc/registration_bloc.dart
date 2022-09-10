import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_registration_app/middleware/extensions/string_extension.dart';
import 'package:login_registration_app/middleware/repositories/api_respository_impl.dart';
import 'package:uuid/uuid.dart';

import '../../middleware/models/user.dart';
import '../../middleware/preferances/shared_preferance.dart';
import 'registration_event.dart';
import 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc(this._apiRepositoryImpl) : super(InitialState()) {
    on<TextFieldValueChangedEvent>(_onTextFieldValueChangedEvent);
    on<CreateUserEvent>(_onCreateUserEvent);
  }

  final _sharedPrefs = SharedPrefs();
  final ApiRepositoryImpl _apiRepositoryImpl;

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
      final result = await _apiRepositoryImpl.createUser(user: user);

      if (result == null) {
        emit(UserCreateInvalidState());
        return;
      }

      if (result is String) {
        await _sharedPrefs.setString('userId', user.id);
        emit(UserCreatedSuccessfullyState());
      }
    } catch (e) {
      throw Exception(e.toString());
    }

    emit(UserCreateInvalidState());
  }
}
