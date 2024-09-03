
import 'package:farmer_app/Screens/Home/HomePage.dart';
import 'package:farmer_app/firebase_options.dart';
import 'package:farmer_app/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'bloc/Auth_bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: _locale,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''),
          Locale('ta', ''),
          Locale('kn', ''),
          Locale('te', ''),
          Locale('hi', '')
        ],
        home: HomePage(), // Use a separate widget for the home screen
      ),
    );
  }
}

