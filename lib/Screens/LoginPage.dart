import 'package:farmer_app/Constants/Colors.dart';
import 'package:farmer_app/Constants/Text.dart';
import 'package:farmer_app/Screens/Home/HomePage.dart';
import 'package:farmer_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final TextEditingController phonenumberController = TextEditingController();

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                        //  widget.Texts[0],
                        S.of(context).login,
                        style: ktextstyle.copyWith(
                            color: kdarkgreen,
                            fontWeight: FontWeight.w700,
                            fontSize: 45),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 40, right: 50, bottom: 20, left: 40),
                      child: Text(
                        S.of(context).enterMobileNumber,
                        style: ktextstyle.copyWith(
                            color: kdarkgreen,
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      height: 46,
                      width: 253,
                      decoration: BoxDecoration(
                          color: kwhite,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Row(
                        children: [
                          const Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: const Text(
                              '+91',
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xff58733D)),
                            ),
                          ),
                          const VerticalDivider(
                            width: 20,
                            thickness: 1,
                            color: Color(0xff58733D),
                          ),
                          Expanded(
                            child: Center(
                              child: TextField(
                                cursorColor: Color(0xff58733D),
                                textAlign: TextAlign.center,
                                controller: phonenumberController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                style: ktextstyle.copyWith(
                                    fontSize: 20, color: Color(0xff58733D)),
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      fontSize: 16, color: Color(0xff58733D)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: ElevatedButton(
                          onPressed: () {
                            //context.read<AuthBloc>().add(RequestOTP(number: phonenumberController.text.trim()));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          }, //Elevated button for send otp
                          style: ElevatedButton.styleFrom(
                              maximumSize: Size(250, 46),
                              minimumSize: Size(180, 35),
                              shadowColor: Colors.black,
                              backgroundColor: kdarkgreen,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: Center(
                            child: Text(
                              S.of(context).sendOtp,
                              style: ktextstyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: kwhite),
                            ),
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).noAccount,
                          style: ktextstyle.copyWith(
                              color: kdarkgreen, fontSize: 12),
                        ),
                        TextButton(
                            onPressed: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>))
                            }, //To navigate to the Signup page
                            child: Text(
                              S.of(context).clickHere,
                              style: ktextstyle.copyWith(
                                  color: kdarkgreen,
                                  decoration: TextDecoration.underline,
                                  fontSize: 12),
                            )),
                      ],
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
