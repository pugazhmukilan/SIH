part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthenticateUser extends AuthEvent {
  final String number;
  AuthenticateUser({required this.number});
}

final class LoggoutUser extends AuthEvent {}

final class RequestOTP extends AuthEvent {
  final String number;
  RequestOTP({required this.number});
}

final class GetUserInformation extends AuthEvent {
  final String ID;
  GetUserInformation({required this.ID});
}

final class FirebaseAuthenticateUser extends AuthEvent {
  final String email;
  final String password;
  FirebaseAuthenticateUser({required this.email, required this.password});
}

final class CreateUser extends AuthEvent {
  final String email;
  final String password;
  final String name;

  final String location;

  CreateUser(
      {required this.email,
      required this.password,
      required this.name,
      required this.location});
}
