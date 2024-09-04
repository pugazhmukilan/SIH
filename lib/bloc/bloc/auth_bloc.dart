import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:farmer_app/Screens/Authentication/FirebaseFunctions.dart';
import 'package:farmer_app/Userinfo.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RequestOTP>((event, emit) {
      //SmsService sms = SmsService();
      //sms.sendSms(event.number);
    });

    on<GetUserInformation>((event, emit) async {
      emit(FetchingUserInformation());
      await Future.delayed(Duration(seconds: 2));
      emit((DataFetched()));

      //emit fetching user infmformation
      //emit((Fetcheddata()));
    });

    on<FirebaseAuthenticateUser>((event, emit) async {
      // call the function to login
      emit((AuthenticationLoading()));
      String? user = await FirebaseAuthService()
          .login(email: event.email, password: event.password);
      // print(user);
      // print("++++++++++++++++++++++++++++++++++++");
      if (user != null) {

        ID = user;
        
        
        StoreInSharedPreference(event.email, event.password);

        emit((AuthenticationSuccessfull()));
      } else {
        emit((AuthenticationFailed(error: "Invalid Credentials")));
      }
    });

    on<CreateUser>((event, emit) async {
      emit((CreatingUserLoading()));
      String? user = await FirebaseAuthService().signup(
          name: event.name,
          place: event.location,
          email: event.email,
          password: event.password);
      print(user);
      print("++++++++++++++++++++++++++++++++++++");
      if (user != null) {
        ID = user;
        StoreInSharedPreference(event.email, event.password);
        emit((AuthenticationSuccessfull()));
      } else {
        emit((AuthenticationFailed(error: "Failed to create user")));
      }
    });


    on<AutoLoggerCheck>((event,emit){
      emit((CheckingForAutoLogger()));
      //check of the shared preference have the email and password whichis not null
      LocalStorageService local = LocalStorageService();
      String email = local.getEmail().toString();
      String password = local.getPassword().toString();
      if(local.getEmail() == null || local.getPassword() == null){
        emit((AutoLoggerNotAvaiable()));
      }
      else{
        emit((AutoLoggerAvaiable(email: email, password: password)));
      }


    });
  }
}


Future<void> StoreInSharedPreference(String email,String password)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("email",email);
  await prefs.setString("password",password);
}

class LocalStorageService {
  late SharedPreferences _prefs;

  // Constructor is now async
  LocalStorageService() {
    _init();
  }

  // Initialize SharedPreferences
  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> storeInSharedPreference(String email, String password) async {
    // Ensure SharedPreferences is initialized
    await _init(); 
    await _prefs.setString("email", email);
    await _prefs.setString("password", password);
  }

  Future<String?> getEmail() async {
    await _init(); 
    return _prefs.getString("email");
  }

  Future<String?> getPassword() async {
    await _init(); 
    return _prefs.getString("password");
  }


}