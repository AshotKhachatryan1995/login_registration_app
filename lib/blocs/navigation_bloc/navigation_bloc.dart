import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_registration_app/middleware/preferances/shared_preferance.dart';

import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(InitialState()) {
    on<CheckRegisteredUserEvent>(_onCheckRegisteredUserEvent);
  }

  final SharedPrefs _sharedPrefs = SharedPrefs();

  Future<void> _onCheckRegisteredUserEvent(
      CheckRegisteredUserEvent event, Emitter<NavigationState> emit) async {
    emit(LoadingState());

    final token = _sharedPrefs.valueByKey('token');

    if (token != null) {
      emit(AuthenticatedState());
      return;
    }

    emit(UnAuthenticatedState());
  }
}
