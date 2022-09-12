import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_registration_app/middleware/extensions/string_extension.dart';
import 'package:login_registration_app/middleware/repositories/api_respository_impl.dart';
import 'package:login_registration_app/middleware/repositories/validation_repository_impl.dart';
import 'package:uuid/uuid.dart';

import '../../middleware/enums/user_registration_field_error_type.dart';
import '../../middleware/models/user.dart';
import '../../middleware/preferances/shared_preferance.dart';
import 'registration_event.dart';
import 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc(this._apiRepositoryImpl, this._validationRepositoryImpl)
      : super(InitialState()) {
    on<CreateUserEvent>(_onCreateUserEvent);
  }

  final _sharedPrefs = SharedPrefs();
  final ApiRepositoryImpl _apiRepositoryImpl;
  final ValidationRepositoryImpl _validationRepositoryImpl;

  Future<void> _onCreateUserEvent(
      CreateUserEvent event, Emitter<RegistrationState> emit) async {
    emit(LoadingState());

    final controllers = event.controllers;

    if (!controllers.areNotEmpty) {
      emit(UserFieldNotValidState(
          errorType: UserRegistrationFieldErrorType.areEmpty));
      return;
    }

    if (!_validationRepositoryImpl
        .isValidEmail(controllers.emailController.text)) {
      emit(UserFieldNotValidState(
          errorType: UserRegistrationFieldErrorType.emailNotValid));
      return;
    }

    if (!_validationRepositoryImpl
        .isValidPhoneNumber(controllers.phoneController.text)) {
      emit(UserFieldNotValidState(
          errorType: UserRegistrationFieldErrorType.phoneNotValid));
      return;
    }

    if (!_validationRepositoryImpl
        .isValidPhoneNumber(controllers.passwordController.text)) {
      emit(UserFieldNotValidState(
          errorType: UserRegistrationFieldErrorType.passwordNotValid));
      return;
    }

    if (controllers.passwordController.text !=
        controllers.confirmPasswordController.text) {
      emit(UserFieldNotValidState(
          errorType: UserRegistrationFieldErrorType.passwordNotMatched));
      return;
    }

    final user = User(
        id: const Uuid().v4(),
        firstName: controllers.firstNameController.text,
        lastName: controllers.lastNameController.text,
        email: controllers.emailController.text,
        phone: (controllers.selectedCountry?.e164CC ?? '') +
            controllers.phoneController.text,
        password: controllers.passwordController.text.generateMd5());

    try {
      final result = await _apiRepositoryImpl.createUser(user: user);

      if (result == null) {
        emit(UserFieldNotValidState(
            errorType: UserRegistrationFieldErrorType.alreadyExists));
        return;
      }

      if (result is User) {
        await _sharedPrefs.setString('userId', result.id);
        emit(UserCreatedSuccessfullyState(user: result));
      }
    } catch (e) {
      throw Exception(e.toString());
    }

    emit(UserCreateInvalidState());
  }
}
