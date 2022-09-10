import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_registration_app/middleware/notifiers/locale_change_notifier.dart';
import 'package:login_registration_app/screens/recovery_password_screen.dart';
import 'package:login_registration_app/screens/registration_screen.dart';
import 'package:login_registration_app/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';
import 'blocs/navigation_bloc/navigation_bloc.dart';
import 'blocs/navigation_bloc/navigation_event.dart';
import 'blocs/navigation_bloc/navigation_state.dart';
import 'middleware/models/user.dart';
import 'middleware/preferances/shared_preferance.dart';
import 'screens/home_screen.dart';
import 'shared/app_localizations/app_localizations.dart';
import 'shared/countries/country_loader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final appDocumentDirectory = await getApplicationDocumentsDirectory();

  // Hive.init(appDocumentDirectory.path);
  // Hive.registerAdapter(UserAdapter());

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
  void initState() {
    super.initState();

    CountryLoader.instance.load();
  }

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
  return ChangeNotifierProvider<LocaleChangeNotifer>(
      create: (context) => LocaleChangeNotifer(),
      child: Consumer<LocaleChangeNotifer>(
          builder: (context, notifer, child) => MaterialApp(
              home: _mainRoute(state),
              locale: notifer.currentLocale,
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ru', 'RU'),
              ],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              onGenerateRoute: (settings) {
                if (settings.name == HomeScreen.route) {
                  return MaterialPageRoute(
                      builder: (context) => _mainRoute(state));
                }

                if (settings.name == SignInScreen.route) {
                  return MaterialPageRoute(
                      builder: (context) => const SignInScreen());
                }

                if (settings.name == RecoveryPasswordScreen.route) {
                  return MaterialPageRoute(
                      builder: (context) => const RecoveryPasswordScreen());
                }

                if (settings.name == RegistrationScreen.route) {
                  return MaterialPageRoute(
                      builder: (context) => const RegistrationScreen());
                }

                assert(false, 'Need to implement ${settings.name}');
                return null;
              })));
}

Widget _mainRoute(NavigationState state) {
  if (state is UnAuthenticatedState) {
    return const SignInScreen();
  }

  if (state is AuthenticatedState) {
    return const HomeScreen();
  }

  return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator()));
}
