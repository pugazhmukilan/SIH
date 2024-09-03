part of 'mic_bloc.dart';

@immutable
sealed class MicEvent {}
final class ListenNow extends MicEvent{}
final class StopListening extends MicEvent{}
