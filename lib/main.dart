import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_registration_app/middleware/notifiers/locale_change_notifier.dart';
import 'package:login_registration_app/middleware/repositories/api_respository_impl.dart';
import 'package:login_registration_app/screens/builders/recovery_password_screen_builder.dart';
import 'package:login_registration_app/screens/builders/registration_screen_builder.dart';
import 'package:login_registration_app/screens/builders/verify_account_screen_buider.dart';
import 'package:login_registration_app/screens/builders/sign_in_screen_builder.dart';
import 'package:login_registration_app/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'blocs/navigation_bloc/navigation_bloc.dart';
import 'blocs/navigation_bloc/navigation_event.dart';
import 'blocs/navigation_bloc/navigation_state.dart';
import 'middleware/models/user.dart';
import 'middleware/notifiers/user_notifier.dart';
import 'middleware/preferances/shared_preferance.dart';
import 'shared/app_localizations/app_localizations.dart';
import 'shared/countries/country_loader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();

    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(UserAdapter());
  }

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
          _navigationBloc = NavigationBloc(ApiRepositoryImpl())
            ..add(CheckRegisteredUserEvent());

          return _navigationBloc;
        },
        child: _render());
  }
}

Widget _render() {
  return _materialApp();
}

Widget _materialApp() {
  return ChangeNotifierProvider<LocaleChangeNotifer>(
      create: (context) => LocaleChangeNotifer(),
      child: ChangeNotifierProvider<UserNotifier>(
          create: (context) => UserNotifier(),
          child:
              Consumer<LocaleChangeNotifer>(builder: (context, notifer, child) {
            return BlocBuilder<NavigationBloc, NavigationState>(
                builder: (context, state) =>
                    BlocListener<NavigationBloc, NavigationState>(
                        listener: _listener,
                        child: MaterialApp(
                            home: _mainRoute(context, state),
                            locale: notifer.currentLocale,
                            initialRoute: '/',
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
                              if (settings.name == '/') {
                                return MaterialPageRoute(
                                    settings: settings,
                                    builder: (context) =>
                                        _mainRoute(context, state));
                              }

                              if (settings.name == SignInScreenBuilder.route) {
                                return MaterialPageRoute(
                                    settings: settings,
                                    builder: (context) =>
                                        const SignInScreenBuilder());
                              }

                              if (settings.name ==
                                  RecoveryPasswordScreenBuilder.route) {
                                return MaterialPageRoute(
                                    settings: settings,
                                    builder: (context) =>
                                        const RecoveryPasswordScreenBuilder());
                              }

                              if (settings.name ==
                                  RegistrationScreenBuilder.route) {
                                return MaterialPageRoute(
                                    settings: settings,
                                    builder: (context) =>
                                        const RegistrationScreenBuilder());
                              }

                              if (settings.name ==
                                  VerifyAccountScreenBuilder.route) {
                                final userName = settings.arguments as String;

                                return MaterialPageRoute(
                                    settings: settings,
                                    builder: (context) =>
                                        VerifyAccountScreenBuilder(
                                            userName: userName));
                              }
                              if (settings.name == WelcomeScreen.route) {
                                return MaterialPageRoute(
                                    settings: settings,
                                    builder: (context) =>
                                        const WelcomeScreen());
                              }
                              assert(
                                  false, 'Need to implement ${settings.name}');
                              return null;
                            })));
          })));
}

Widget _mainRoute(BuildContext context, NavigationState state) {
  if (state is UnAuthenticatedState) {
    return const SignInScreenBuilder();
  }

  if (state is AuthenticatedState) {
    return const WelcomeScreen();
  }

  return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator()));
}

void _listener(context, state) {
  if (state is AuthenticatedState) {
    Provider.of<UserNotifier>(context, listen: false)
        .setNewUser(user: state.user);
  }
}
