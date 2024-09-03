part of 'camera_bloc.dart';

@immutable
sealed class CameraState {}

final class CameraLoading extends CameraState {}

final class CameraSuccessfull extends CameraState {
  String Successmessage = "";
  String Description = "";
  String Cause = "";
  String Solution = "";
  int riskLevel = 0;
  final File? imageFile;
  CameraSuccessfull({
    required this.Cause,
    required this.Description,
    required this.Solution,
    required this.Successmessage,
    required this.riskLevel,
    this.imageFile,
  });
}

final class CameraFailed extends CameraState {
  String FailureMessage = "";
  CameraFailed({required this.FailureMessage});
}

final class CameraInitial extends CameraState {}
