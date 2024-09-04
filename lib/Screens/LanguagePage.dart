import 'package:farmer_app/Constants/Colors.dart';
import 'package:farmer_app/Constants/Text.dart';
import 'package:farmer_app/Screens/Authentication/SignPage.dart';

import 'package:farmer_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:farmer_app/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  Locale _locale = Locale('en');

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });

    MainApp.setLocale(context, locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: const Image(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/Login_Page_bg.png")),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                height: 403,
                width: 330,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Text(
                        "Select language",
                        style: ktextstyle.copyWith(
                            color: kdarkgreen,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          //English
                          padding: EdgeInsets.only(top: 40),
                          child: ElevatedButton(
                              onPressed: () async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString('selectedLanguage', 'en');
                                onTap:
                                () => _changeLanguage(Locale('en'));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupPage()));
                              }, //Elevated button for send otp
                              style: ElevatedButton.styleFrom(
                                  maximumSize: Size(120, 46),
                                  minimumSize: Size(100, 30),
                                  shadowColor: Colors.black,
                                  backgroundColor: klangbutton,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Center(
                                child: Text(
                                  "English",
                                  style: ktextstyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: kdarkgreen),
                                ),
                              )),
                        ),
                        Padding(
                          //Tamil
                          padding: EdgeInsets.only(top: 40),
                          child: ElevatedButton(
                              onPressed: () async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString('selectedLanguage', 'ta');
                                _changeLanguage(Locale('ta'));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupPage()));
                              }, //Elevated button for send otp
                              style: ElevatedButton.styleFrom(
                                  maximumSize: Size(120, 46),
                                  minimumSize: Size(100, 30),
                                  shadowColor: Colors.black,
                                  backgroundColor: klangbutton,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Center(
                                child: Text(
                                  "தமிழ்",
                                  style: ktextstyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: kdarkgreen),
                                ),
                              )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          //Telugu
                          padding: EdgeInsets.only(top: 40),
                          child: ElevatedButton(
                              onPressed: () async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString('selectedLanguage', 'kn');
                                _changeLanguage(Locale('kn'));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupPage()));
                              }, //Elevated button for send otp
                              style: ElevatedButton.styleFrom(
                                  maximumSize: Size(120, 46),
                                  minimumSize: Size(100, 30),
                                  shadowColor: Colors.black,
                                  backgroundColor: klangbutton,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Center(
                                child: Text(
                                  "తెలుగు",
                                  style: ktextstyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: kdarkgreen),
                                ),
                              )),
                        ),
                        Padding(
                          //telugu
                          padding: EdgeInsets.only(top: 40),
                          child: ElevatedButton(
                              onPressed: () async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString('selectedLanguage', 'te');
                                _changeLanguage(Locale('te'));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupPage()));
                              }, //Elevated button for send otp
                              style: ElevatedButton.styleFrom(
                                  maximumSize: Size(120, 46),
                                  minimumSize: Size(100, 30),
                                  shadowColor: Colors.black,
                                  backgroundColor: klangbutton,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Center(
                                child: Text(
                                  "ಕನ್ನಡ",
                                  style: ktextstyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: kdarkgreen),
                                ),
                              )),
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                          //Hindi
                          padding: EdgeInsets.only(top: 40),
                          child: ElevatedButton(
                            onPressed: () async {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString('selectedLanguage',
                                  'hi'); // Save Hindi language preference
                              // Ensure you await the language saving process
                              _changeLanguage(
                                  Locale('hi')); // Apply the new language
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              maximumSize: Size(120, 46),
                              minimumSize: Size(100, 30),
                              shadowColor: Colors.black,
                              backgroundColor: klangbutton,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "हिंदी", // Hindi text
                                style: ktextstyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: kdarkgreen,
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ), //Column of the container
              ),
            ),
          )
        ],
      ),
    );
  }
}
