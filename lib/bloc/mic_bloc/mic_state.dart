part of 'mic_bloc.dart';

@immutable
sealed class MicState {}

final class MicInitial extends MicState {}
final class Listening extends MicState{}
final class NotListening extends MicState{}// TODO: implement this state
