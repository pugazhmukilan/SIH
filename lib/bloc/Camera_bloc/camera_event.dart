part of 'camera_bloc.dart';

@immutable
sealed class CameraEvent {}

final class CameraCaptured extends CameraEvent {}

class ImageCaptured extends CameraEvent {
  final File? imageFile; // This will hold the captured image file

  ImageCaptured({this.imageFile});
}
