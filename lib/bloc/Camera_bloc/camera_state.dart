part of 'camera_bloc.dart';

@immutable
sealed class CameraState {}

class CameraLoading extends CameraState {}

class CameraSuccessfull extends CameraState {
  final String successMessage;
  final String description;
  final String cause;
  final String solution;
  final String riskLevel;
  final File? imageFile;
  final String diseasename;
  CameraSuccessfull({
    required this.diseasename,
    required this.cause,
    required this.description,
    required this.solution,
    required this.successMessage,
    required this.riskLevel,
    this.imageFile,
  });

  @override
  List<Object?> get props =>
      [successMessage, description, cause, solution, riskLevel, imageFile];
}

class CameraFailed extends CameraState {
  final String failureMessage;

  CameraFailed({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}

class CameraInitial extends CameraState {}
