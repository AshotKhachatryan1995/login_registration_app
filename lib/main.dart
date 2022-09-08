import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_registration_app/screens/recovery_password_screen.dart';
import 'package:login_registration_app/screens/sign_in_screen.dart';

import 'blocs/navigation_bloc/navigation_bloc.dart';
import 'blocs/navigation_bloc/navigation_event.dart';
import 'blocs/navigation_bloc/navigation_state.dart';
import 'middleware/preferances/shared_preferance.dart';
import 'screens/home_screen.dart';
import 'shared/loading_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize preferences
  await SharedPrefs().init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final NavigationBloc _navigationBloc;

  @override
  void dispose() {
    _navigationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationBloc>(
        create: (_) {
          _navigationBloc = NavigationBloc()..add(CheckRegisteredUserEvent());

          return _navigationBloc;
        },
        child: _render());
  }
}

Widget _render() {
  return BlocBuilder<NavigationBloc, NavigationState>(
    builder: (context, state) => _materialApp(state),
  );
}

Widget _materialApp(NavigationState state) {
  return Theme(
      data: ThemeData.light(),
      child: MaterialApp(
          home: _mainRoute(state),
          onGenerateRoute: (settings) {
            if (settings.name == HomeScreen.route) {
              return MaterialPageRoute(builder: (context) => _mainRoute(state));
            }

            if (settings.name == SignInScreen.route) {
              return MaterialPageRoute(
                  builder: (context) => const SignInScreen());
            }

            assert(false, 'Need to implement ${settings.name}');
            return null;
          }));
}

Widget _mainRoute(NavigationState state) {
  if (state is UnAuthenticatedState) {
    return const RecoveryPasswordScreen();
  }

  if (state is AuthenticatedState) {
    return const HomeScreen();
  }

  return const LoadingWidget();
}
