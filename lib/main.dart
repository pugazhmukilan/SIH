import 'package:farmer_app/Screens/Authentication/LoginPage.dart';
import 'package:farmer_app/Screens/Authentication/SignPage.dart';
import 'package:farmer_app/Screens/Home/HomePage.dart';
import 'package:farmer_app/Screens/LanguagePage.dart';
import 'package:farmer_app/bloc/Camera_bloc/camera_bloc.dart';
import 'package:farmer_app/bloc/mic_bloc/mic_bloc.dart';
import 'package:farmer_app/firebase_options.dart';
import 'package:farmer_app/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //cerate a instance for the shared preference
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
  static void setLocale(BuildContext context, Locale locale) {
    _MainAppState? state = context.findAncestorStateOfType<_MainAppState>();
    state!.setLocale(locale);
  }
}

class _MainAppState extends State<MainApp> {
  Locale _locale = Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => MicBloc(),
        ),
        BlocProvider(create: (context) => CameraBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: _locale,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('ta', ''),
          Locale('kn', ''),
          Locale('te', ''),
          Locale('hi', '')
        ],
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is CheckingForAutoLogger) {
              CircularProgressIndicator(); // TODO: implement listener
            }
            if (state is AutoLoggerNotAvaiable) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> route) =>
                    false, // This will remove all previous routes
              );
            }
          },
          builder: (context, state) {
            if (state is AutoLoggerAvaiable) {
              context.read<AuthBloc>().add(FirebaseAuthenticateUser(
                  email: state.email, password: state.password));
            }

            return LanguagePage();
          },
        ), // Use a separate widget for the home screen
        // Use a separate widget for the home screen
      ),
    );
  }
}
