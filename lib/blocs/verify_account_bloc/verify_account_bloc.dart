import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_registration_app/middleware/enums/user_registration_field_error_type.dart';
import 'package:login_registration_app/middleware/models/user.dart';
import 'package:login_registration_app/middleware/repositories/api_respository_impl.dart';
import 'package:login_registration_app/middleware/repositories/validation_repository_impl.dart';

import 'verify_account_event.dart';
import 'verify_account_state.dart';

class VerifyAccountBloc extends Bloc<VerifyAccountEvent, VerifyAccountState> {
  VerifyAccountBloc(this._apiRepositoryImpl, this._validationRepositoryImpl)
      : super(InitialState()) {
    on<VerifyCodeEvent>(_onVerifyCodeEvent);
    on<SetNewPasswordEvent>(_onSetNewPasswordEvent);
    on<ResendCodeEvent>(_onResendCodeEvent);
  }

  final ApiRepositoryImpl _apiRepositoryImpl;
  final ValidationRepositoryImpl _validationRepositoryImpl;

  Future<void> _onVerifyCodeEvent(
      VerifyCodeEvent event, Emitter<VerifyAccountState> emit) async {
    emit(LoadingState());

    try {
      final result = await _apiRepositoryImpl.verifyCode(code: event.code);

      if (result is bool) {
        emit(result
            ? VerifyAccountSuccessedState()
            : VerifyAccountInvalidState());
      }
    } catch (e) {
      emit(VerifyAccountInvalidState());
      throw Exception(e.toString());
    }
  }

  Future<void> _onSetNewPasswordEvent(
      SetNewPasswordEvent event, Emitter<VerifyAccountState> emit) async {
    emit(LoadingState());

    final controllers = event.controllers;
    try {
      if (!controllers.areNotEmpty) {
        emit(SetPasswordInvalidState(
            errorType: UserRegistrationFieldErrorType.areEmpty));
        return;
      }

      if (!_validationRepositoryImpl
          .isValidPassword(controllers.passwordController.text)) {
        emit(SetPasswordInvalidState(
            errorType: UserRegistrationFieldErrorType.passwordNotValid));
        return;
      }

      if (controllers.passwordController.text !=
          controllers.confirmPasswordController.text) {
        emit(SetPasswordInvalidState(
            errorType: UserRegistrationFieldErrorType.passwordNotMatched));
        return;
      }

      final result = await _apiRepositoryImpl.setNewPassword(
          userName: event.userName,
          password: controllers.passwordController.text);

      if (result == null) {
        emit(PasswordUpdateInvalidState());
        return;
      }

      if (result is User) {
        emit(PasswordSuccessfullyUpdatedState(user: result));
        return;
      }
    } catch (e) {
      emit(PasswordUpdateInvalidState());
      throw Exception(e.toString());
    }
  }

  Future<void> _onResendCodeEvent(
      ResendCodeEvent event, Emitter<VerifyAccountState> emit) async {
    emit(LoadingState());

    try {
      final result = await _apiRepositoryImpl.resendCode();

      if (result is bool) {
        emit(result
            ? VerifyAccountSuccessedState()
            : VerifyAccountInvalidState());
      }
    } catch (e) {
      emit(VerifyAccountInvalidState());
      throw Exception(e.toString());
    }
  }
}
