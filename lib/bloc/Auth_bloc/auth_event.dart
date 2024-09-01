part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
final class AuthenticateUser extends AuthEvent{
  final String number;
  AuthenticateUser({required this.number});
}
final class LoggoutUser extends AuthEvent{
  
}
final class RequestOTP extends AuthEvent{
   final String number;
  RequestOTP({required this.number});
}
