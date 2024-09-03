import 'package:farmer_app/Screens/Home/HomePage.dart';
import 'package:farmer_app/Screens/LoginPage.dart';
import 'package:farmer_app/Userinfo.dart';
import 'package:farmer_app/bloc/bloc/auth_bloc.dart';
import 'package:farmer_app/widgets/CustomSnackBar.dart';
import 'package:farmer_app/widgets/dialoguebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameController = TextEditingController();
  final _placeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signup')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if(state is AuthenticationLoading){
              LoadingDialog.show(context, message: "Creating user");
          }
          if(state is AuthenticationSuccessfull){
            
            context.read<AuthBloc>().add(GetUserInformation(ID: ID));
            Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
          }
          if(state is AuthenticationFailed){
            if(LoadingDialog.isDialogOpen()){
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
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _placeController,
                  decoration: InputDecoration(labelText: 'Place'),
                ),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                ),
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
                  onPressed:(){
                    context.read<AuthBloc>().add(CreateUser(email: _emailController.text.trim(),
                                                                      password: _passwordController.text.trim(),
                                                                      name: _nameController.text.trim(), 
                                                                      number: phonenumberController.text, 
                                                                      location: _placeController.text.trim()));
                  } ,
                  child: Text('Signup'),
                ),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                }, child: Text("login ")),
              ],
            ),
          );
        },
      ),
    );
  }

  void _signup() {
    final name = _nameController.text;
    final place = _placeController.text;
    final phone = _phoneController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    // Call your signup function here
    signup(name, place, phone, email, password);
  }
}

void signup(
    String name, String place, String phone, String email, String password) {
  // Implement your signup logic here
  print('Name: $name');
  print('Place: $place');
  print('Phone: $phone');
  print('Email: $email');
  print('Password: $password');
}
