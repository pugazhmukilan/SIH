import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:farmer_app/Screens/Authentication/FirebaseFunctions.dart';
import 'package:farmer_app/Userinfo.dart';
//import http as http
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RequestOTP>((event, emit) {
      SmsService sms = SmsService();
      sms.sendSms(event.number);
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
      print(user);
      print("++++++++++++++++++++++++++++++++++++");
      if (user != null) {
        //call fetch data event
        ID = user;
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
        emit((AuthenticationSuccessfull()));
      } else {
        emit((AuthenticationFailed(error: "Failed to create user")));
      }
    });
  }
}

class SmsService {
  final String _baseUrl =
      'https://verify.twilio.com/v2/Services/VAf3a01df767de801c799c4d3106999f49';
  final String _accountSid = 'AC027bb3997058fbb128ace2a100806e0c';
  final String _authToken = 'd2afec6ecd89c731d7a87e29c3e4ee62';

  Future<void> sendSms(String to) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/Verifications'),
      headers: {
        'Authorization':
            'Basic ' + base64Encode(utf8.encode('$_accountSid:$_authToken')),
        'Content-Type':
            'application/x-www-form-urlencoded', // Ensure the correct content type
      },
      body: {
        'To': '+91${to}', // Ensure the phone number is in E.164 format
        'Channel': 'sms',
      },
    );

    if (response.statusCode == 201) {
      print('SMS sent successfully.');
    } else {
      print('Failed to send SMS: ${response.body}');
    }
  }

  Future<void> verifySms(String to, String code) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/VerificationCheck'),
      headers: {
        'Authorization':
            'Basic ' + base64Encode(utf8.encode('$_accountSid:$_authToken')),
        'Content-Type':
            'application/x-www-form-urlencoded', // Ensure the correct content type
      },
      body: {
        'To': '+$to', // Ensure the phone number is in E.164 format
        'Code': code,
      },
    );

    if (response.statusCode == 200) {
      print('Verification successful.');
    } else {
      print('Failed to verify SMS: ${response.body}');
    }
  }
}


// curl.exe -X POST "https://verify.twilio.com/v2/Services/VAf3a01df767de801c799c4d3106999f49/Verifications" ^
//   --data-urlencode "To=+919940411686" ^
//   --data-urlencode "Channel=sms" ^
//   -u "AC027bb3997058fbb128ace2a100806e0c:d2afec6ecd89c731d7a87e29c3e4ee62"

// echo
// echo -n "Please enter the OTP:"
// read OTP_CODE

// curl.exe -X POST "https://verify.twilio.com/v2/Services/VAf3a01df767de801c799c4d3106999f49/VerificationCheck" ^
//   --data-urlencode "To=+919940411686" ^
//   --data-urlencode "Code=$OTP_CODE" ^
//   -u "AC027bb3997058fbb128ace2a100806e0c:d2afec6ecd89c731d7a87e29c3e4ee62"