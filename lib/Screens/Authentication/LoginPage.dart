
import 'package:farmer_app/Screens/Authentication/SignPage.dart';
import 'package:farmer_app/Screens/Home/HomePage.dart';
import 'package:farmer_app/Userinfo.dart';
import 'package:farmer_app/bloc/bloc/auth_bloc.dart';
import 'package:farmer_app/widgets/CustomSnackBar.dart';
import 'package:farmer_app/widgets/dialoguebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if(state is AuthenticationLoading){
            LoadingDialog.show(context, message: 'Logging in...');
          }
          if(state is AuthenticationSuccessfull){
            
            context.read<AuthBloc>().add(GetUserInformation(ID: ID));
            Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
          }
          if(state is AuthenticationFailed){
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
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email ID'),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(FirebaseAuthenticateUser(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim()));
                  },
                  child: Text('Login'),
                ),
                ElevatedButton(onPressed: 
                (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupPage()));
                }, child: Text("signup"))
              ],
            ),
          );
        },
      ),
    );
  }

  void _login() {
    final email = _emailController.text;
    final password = _passwordController.text;

    // Call your login function here
    login(email, password);
  }
}

void login(String email, String password) {
  // Implement your login logic here
  print('Email: $email');
  print('Password: $password');
}
