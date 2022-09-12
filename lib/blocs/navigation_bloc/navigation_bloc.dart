import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_registration_app/middleware/models/user.dart';
import 'package:login_registration_app/middleware/preferances/shared_preferance.dart';
import 'package:login_registration_app/middleware/repositories/api_respository_impl.dart';

import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc(this._apiRepositoryImpl) : super(InitialState()) {
    on<CheckRegisteredUserEvent>(_onCheckRegisteredUserEvent);
  }

  final ApiRepositoryImpl _apiRepositoryImpl;
  final SharedPrefs _sharedPrefs = SharedPrefs();

  Future<void> _onCheckRegisteredUserEvent(
      CheckRegisteredUserEvent event, Emitter<NavigationState> emit) async {
    emit(LoadingState());
    try {
      final userId = _sharedPrefs.valueByKey('userId');

      if (userId != null) {
        final result = await _apiRepositoryImpl.getUserByID(userId: userId);

        if (result is User) {
          emit(AuthenticatedState(user: result));
          return;
        }
      }
    } catch (e) {

      throw Exception(e.toString());
    }

      emit(UnAuthenticatedState());

  }
}
