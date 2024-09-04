part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthenticationSuccessfull extends AuthState {}

final class AuthenticationFailed extends AuthState {
  final String error;
  AuthenticationFailed({required this.error});
}

final class AuthenticationLoading extends AuthState {}

final class FetchingUserInformation extends AuthState {}

final class DataFetched extends AuthState {}

final class CreatingUserLoading extends AuthState {}
