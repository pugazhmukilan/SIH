import 'dart:convert';
import 'dart:io';
import 'package:farmer_app/Userinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as Http;
part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraInitial()) {
    on<ImageCaptured>((event, emit) async {
      if (event.imageFile != null) {
        emit(CameraLoading());
        final String base64Image =
            base64Encode(event.imageFile!.readAsBytesSync());
        final url = Uri.parse(
            "https://sabarikrishnan.us-east-1.modelbit.com/v1/prediction/latest");
        print("Data sent+++++++++++++++++++");
        final headers = {
          'Content-Type': 'application/json',
        };
        final body = jsonEncode({'data': '$base64Image'});

        final response = await Http.post(url, headers: headers, body: body);
        print("Http request successfull");
        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonMap =
              jsonDecode(response.body) as Map<String, dynamic>;

// Convert the dynamic map to the expected map
          Map<String, Map<String, String>> diseaseData =
              jsonMap.map((key, value) {
            final Map<String, String> valueMap = (value as Map<String, dynamic>)
                .map((k, v) => MapEntry(k, v.toString()));
            return MapEntry(key, valueMap);
          });
          print("$diseaseData");
          String diseaseName = diseaseData.keys
              .first; //This is given as data in the structure but eventhough it is set dynamically so changes acoordinly.

          var brownSpotInfo = DiseaseInfo.fromMap(diseaseData['data']!);
          String translatedCause = '';
          String translatedSolution = '';
          String translatedName = '';
          String translatedDescription = '';
          String translatedSuccessMessage = '';
          //Running this to start the function defined to set the variable.
          Future<void> someFunction() async {
            print("Entered the translating function");

            // Perform all the translations asynchronously
            translatedCause =
                await translatingText(brownSpotInfo.cause, '$UserLanguage');
            translatedSolution =
                await translatingText(brownSpotInfo.solution, '$UserLanguage');
            translatedName = await translatingText(
                brownSpotInfo.diseasename, '$UserLanguage');
            translatedDescription = await translatingText(
                brownSpotInfo.description, '$UserLanguage');
            translatedSuccessMessage = await translatingText(
                brownSpotInfo.successMessage, '$UserLanguage');

            print("+++++++++++++++++++++++++++++++" +
                translatedSolution); // This will print the translated text
            print("Emitting successful state");

            // /  Emit the success state after translations are done
            emit(CameraSuccessfull(
              diseasename: translatedName,
              cause: translatedCause,
              description: translatedDescription,
              solution: translatedSolution,
              successMessage: translatedSuccessMessage,
              riskLevel: brownSpotInfo.riskLevel,
              imageFile: event.imageFile,
            ));
          }

// Call the function and wait for it to complete
          await someFunction();

          // Assuming this is inside an async function
          //   String transalatedCause = '';
          //   String translatedSolution = '';
          //   String transalatedname = '';
          //   String translatedDiscription = '';
          //   String transalatedsuccessMesssage = '';
          //   Future<String> someFunction() async {
          //     print("Entered the translating function");

          //     // Perform all the translations asynchronously
          //     transalatedCause = await translatingText(brownSpotInfo.cause, 'ta');
          //     translatedSolution =
          //         await translatingText(brownSpotInfo.solution, 'ta');
          //     transalatedname =
          //         await translatingText(brownSpotInfo.diseasename, 'ta');
          //     translatedDiscription =
          //         await translatingText(brownSpotInfo.description, 'ta');
          //     transalatedsuccessMesssage =
          //         await translatingText(brownSpotInfo.successMessage, 'ta');

          //     print(translatedSolution); // This will print the translated text
          //     print("Emitting successful state");

          //     // If `future` is necessary, ensure it completes before emitting

          //     // Emit the success state
          //   }

          //  await someFunction();
          //   emit(CameraSuccessfull(
          //     diseasename: transalatedname,
          //     cause: transalatedCause,
          //     description: translatedDiscription,
          //     solution: translatedSolution,
          //     successMessage: transalatedsuccessMesssage,
          //     riskLevel: brownSpotInfo.riskLevel,
          //     imageFile: event.imageFile,
          //   ));
        } else {
          print("Api failed++++++++++++++++++++++++++++++");
          emit(CameraFailed(failureMessage: "Api error"));
        }

        // Map<String, Map<String, String>> diseaseData = {
        //   'Brown Spot': {
        //     'description':
        //         'Brown spot is a prevalent disease in rice crops characterized by the appearance of small, round, brown lesions on the leaves. These lesions often have a darker center and a yellowish halo around them. The disease can significantly reduce the photosynthetic area of the plant, leading to decreased yield and poor grain quality.',
        //     'cause':
        //         'Brown spot is caused by the fungal pathogen Bipolaris oryzae, which thrives in warm and humid conditions. The fungus spreads through infected seeds, plant debris, and water.',
        //     'solution':
        //         'To manage brown spot, use resistant rice varieties that are less susceptible to the disease. Ensure proper field drainage to reduce humidity. Practice crop rotation and remove infected plant debris. Fungicide applications can be effective if applied at the early stages of infection.',
        //     'emergency_level': '3'
        //   },
        // };
      } else {
        emit(CameraFailed(failureMessage: 'No image provided'));
      }
    });
  }

  get http => null;
}

class DiseaseInfo {
  final String description;
  final String cause;
  final String solution;
  final String successMessage;
  final String riskLevel;
  final String diseasename;

  DiseaseInfo({
    required this.diseasename,
    required this.description,
    required this.cause,
    required this.solution,
    this.successMessage = 'Solution applied successfully.',
    this.riskLevel = '',
  });

  factory DiseaseInfo.fromMap(Map<String, String> map) {
    return DiseaseInfo(
      diseasename: map['disease'] ?? '',
      description: map['description'] ?? '',
      cause: map['cause'] ?? '',
      solution: map['solution'] ?? '',
      successMessage: map['successMessage'] ?? 'Solution applied successfully.',
      riskLevel: map['emergency_level'] ?? '',
    );
  }
}

Future<String> translatingText(String inputText, String selectedOutCode) async {
  var translator = GoogleTranslator();

  // Translate the text and return the result
  var translatedText =
      await translator.translate(inputText, from: 'en', to: selectedOutCode);

  return translatedText.text; // Return the translated text as a String
}
