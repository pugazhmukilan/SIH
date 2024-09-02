
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SmsService {
  final String _baseUrl = dotenv.env['TWILIO_BASE_URL']!;
  final String _accountSid = dotenv.env['TWILIO_ACCOUNT_SID']!;
  final String _authToken = dotenv.env['TWILIO_AUTH_TOKEN']!;

  Future<void> sendSms(String to) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/Verifications'),
      headers: {
        'Authorization': 'Basic ' + base64Encode(utf8.encode('$_accountSid:$_authToken')),
        'Content-Type': 'application/x-www-form-urlencoded', // Ensure the correct content type
      },
      body: {
        'To': '+$to', // Ensure the phone number is in E.164 format
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
        'Authorization': 'Basic ' + base64Encode(utf8.encode('$_accountSid:$_authToken')),
        'Content-Type': 'application/x-www-form-urlencoded', // Ensure the correct content type
      },
      body: {
        'To': '+91$to', // Ensure the phone number is in E.164 format
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

