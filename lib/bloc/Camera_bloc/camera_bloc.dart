import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:meta/meta.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraInitial()) {
    // TODO: implement event handler
    on<ImageCaptured>((event, emit) {
      Map<String, Map<String, String>> diseaseData = {
        'Brown Spot': {
          'description': ('Brown spot is a prevalent disease in rice crops characterized by the appearance of '
              'small, round, brown lesions on the leaves. These lesions often have a darker center and '
              'a yellowish halo around them. The disease can significantly reduce the photosynthetic area '
              'of the plant, leading to decreased yield and poor grain quality.'),
          'cause':
              ('Brown spot is caused by the fungal pathogen Bipolaris oryzae, which thrives in warm and '
                  'humid conditions. The fungus spreads through infected seeds, plant debris, and water.'),
          'solution': ('To manage brown spot, use resistant rice varieties that are less susceptible to the disease. '
              'Ensure proper field drainage to reduce humidity. Practice crop rotation and remove infected '
              'plant debris. Fungicide applications can be effective if applied at the early stages of infection.'),
        },
      };
      var brownSpotInfo = DiseaseInfo.fromMap(diseaseData['Brown Spot']!);

      emit(CameraSuccessfull(
        Cause: "${brownSpotInfo.cause}",
        Description: "${brownSpotInfo.description}",
        Solution: " ${brownSpotInfo.solution}",
        Successmessage: "${brownSpotInfo.successMessage}",
        riskLevel: int.parse(brownSpotInfo.riskLevel),
        imageFile: event.imageFile,
      ));
    });
  }
}

class DiseaseInfo {
  final String description;
  final String cause;
  final String solution;
  final String successMessage;
  final String riskLevel;

  DiseaseInfo({
    required this.description,
    required this.cause,
    required this.solution,
    this.successMessage = '', // Default value if not provided
    this.riskLevel = '', // Default value if not provided
  });

  // Factory method to create a DiseaseInfo instance from a map
  factory DiseaseInfo.fromMap(Map<String, String> map) {
    return DiseaseInfo(
      description: map['description'] ?? '',
      cause: map['cause'] ?? '',
      solution: map['solution'] ?? '',
      successMessage: map['successMessage'] ?? 'Solution applied successfully.',
      riskLevel: map['riskLevel'] ?? 'Moderate',
    );
  }
}
