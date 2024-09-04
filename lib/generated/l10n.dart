// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get name {
    return Intl.message(
      'Enter your name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your mobile number`
  String get enterMobileNumber {
    return Intl.message(
      'Enter your mobile number',
      name: 'enterMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email id`
  String get enteremailid {
    return Intl.message(
      'Enter your email id',
      name: 'enteremailid',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enterpassword {
    return Intl.message(
      'Enter your password',
      name: 'enterpassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your location`
  String get enteryourlocation {
    return Intl.message(
      'Enter your location',
      name: 'enteryourlocation',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP`
  String get sendOtp {
    return Intl.message(
      'Send OTP',
      name: 'sendOtp',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get noAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Click here`
  String get clickHere {
    return Intl.message(
      'Click here',
      name: 'clickHere',
      desc: '',
      args: [],
    );
  }

  /// `listening..`
  String get listening {
    return Intl.message(
      'listening..',
      name: 'listening',
      desc: '',
      args: [],
    );
  }

  /// `Have an account?`
  String get Haveaccount {
    return Intl.message(
      'Have an account?',
      name: 'Haveaccount',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get Createaccount {
    return Intl.message(
      'Create an account',
      name: 'Createaccount',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'kn'),
      Locale.fromSubtags(languageCode: 'ta'),
      Locale.fromSubtags(languageCode: 'te'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
