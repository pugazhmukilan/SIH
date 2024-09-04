import 'package:farmer_app/Constants/Colors.dart';
import 'package:farmer_app/Constants/Text.dart';
import 'package:farmer_app/Screens/Authentication/SignPage.dart';
import 'package:farmer_app/Screens/Home/HomePage.dart';
import 'package:farmer_app/Userinfo.dart';
import 'package:farmer_app/bloc/bloc/auth_bloc.dart';
import 'package:farmer_app/generated/l10n.dart';
import 'package:farmer_app/widgets/CustomSnackBar.dart';
import 'package:farmer_app/widgets/dialoguebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      // TODO: implement listener
      if (state is AuthenticationLoading) {
        LoadingDialog.show(context, message: 'Logging in...');
      }
      if (state is AuthenticationSuccessfull) {
        UserLanguage = Localizations.localeOf(context).languageCode;
        context.read<AuthBloc>().add(GetUserInformation(
              ID: ID,
            ));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) =>
              false, // This will remove all previous routes
        );
      }
      if (state is AuthenticationFailed) {
        //CHECK DIALOGUE BOX IS OPEN?
        if (LoadingDialog.isDialogOpen()) {
          LoadingDialog.hide(context);
        }
        SnackbarHelper.showSnackbar(
          context,
          title: 'Failed',
          message: 'Your action was unsuccessfull!',
          icon: Icons.close,
          color: Colors.red,
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Positioned.fill(
              child: const Image(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/Login_Page_bg.png"),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                // Ensure scrolling
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: 330,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 30.0),
                      child: Column(
                        mainAxisSize: MainAxisSize
                            .min, // Make the column adjust based on its content
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: Text(
                              S.of(context).login,
                              style: ktextstyle.copyWith(
                                color: kdarkgreen,
                                fontWeight: FontWeight.w700,
                                fontSize: 30,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, right: 50, bottom: 10, left: 8),
                            child: Text(
                              S.of(context).enteremailid,
                              style: ktextstyle.copyWith(
                                color: kdarkgreen,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          _buildTextField(
                              emailController, S.of(context).enteremailid),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, right: 50),
                            child: Text(
                              S.of(context).enterpassword,
                              style: ktextstyle.copyWith(
                                color: kdarkgreen,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          _buildPasswordField(passwordController),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    //If you dont have an account
                                    S.of(context).noAccount,
                                    style: ktextstyle.copyWith(
                                      color: kdarkgreen,
                                      fontSize: 12,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignupPage()));
                                  }, // To navigate to the Signup page
                                  child: Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    S.of(context).clickHere,
                                    style: ktextstyle.copyWith(
                                      color: kdarkgreen,
                                      decoration: TextDecoration.underline,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                    FirebaseAuthenticateUser(
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim()));
                              }, // Elevated button for send OTP
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(180, 35),
                                shadowColor: Colors.black,
                                backgroundColor: kdarkgreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Text(
                                S.of(context).login,
                                style: ktextstyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: kwhite,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }));
  }

  //         return Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             children: [
  //               TextField(
  //                 controller: emailController,
  //                 decoration: InputDecoration(labelText: 'Email ID'),
  //                 keyboardType: TextInputType.emailAddress,
  //               ),
  //               TextField(
  //                 controller: passwordController,
  //                 decoration: InputDecoration(labelText: 'Password'),
  //                 obscureText: true,
  //               ),
  //               SizedBox(height: 20),
  //               ElevatedButton(
  //                 onPressed: () {
  //                   context.read<AuthBloc>().add(FirebaseAuthenticateUser(
  //                       email: emailController.text.trim(),
  //                       password: passwordController.text.trim()));
  //                 },
  //                 child: Text('Login'),
  //               ),
  //               ElevatedButton(
  //                   onPressed: () {
  //                     Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (context) => SignupPage()));
  //                   },
  //                   child: Text("signup"))
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: 45,
        width: 253,
        decoration: BoxDecoration(
          color: kwhite,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              cursorColor: Color(0xff58733D),
              maxLines: 1,
              textAlign: TextAlign.center,
              controller: controller,
              style:
                  ktextstyle.copyWith(fontSize: 16, color: Color(0xff58733D)),
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 16, color: Color(0xff58733D)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: 40,
        width: 253,
        decoration: BoxDecoration(
          color: kwhite,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: kdarkgreen,
                  size: 24,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 3,
                horizontal: 10,
              ),
              isDense: true,
            ),
            cursorColor: kdarkgreen,
            obscureText: _obscureText,
            controller: controller,
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  void _login() {
    final email = emailController.text;
    final password = passwordController.text;

    // Call your login function here
    login(email, password);
  }

  void login(String email, String password) {
    // Implement your login logic here
    print('Email: $email');
    print('Password: $password');
  }
}
