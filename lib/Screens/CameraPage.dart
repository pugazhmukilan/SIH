import 'package:camera/camera.dart';
import 'package:farmer_app/Constants/Colors.dart';
import 'package:farmer_app/Constants/Text.dart';
import 'package:farmer_app/Screens/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:farmer_app/bloc/Camera_bloc/camera_bloc.dart';
import 'dart:io';

import 'package:linear_progress_bar/linear_progress_bar.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    pickImage(); // Pick an image when the page is loaded
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        // Convert XFile to File
        final File imageFile = File(image.path);

        print(
            "imge selected++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
        // Add the ImageCaptured event with the File type
        context
            .read<CameraBloc>()
            .add(ImageCaptured(imageFile: File(image.path)));
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraBloc, CameraState>(
      builder: (context, state) {
        if (state is CameraSuccessfull) {
          print(
              "inside the successfull sgtate+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
          return Scaffold(
              backgroundColor: kwhite,
              appBar: AppBar(
                  backgroundColor: kwhite,
                  title: const Text(
                    'Report of analysis',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  )),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        //Row for image and the words.
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (state.imageFile != null)
                            Container(
                              width: 90,
                              height: 102,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey[200],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  state.imageFile!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width:
                                    200, // Fixed width for single line of text
                                child: Text(
                                  state.diseasename,
                                  style: ktextstyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: kdarkgreen,
                                      fontSize:
                                          17), // Adjust text style as needed
                                  maxLines:
                                      2, // Set the maximum number of lines
                                  overflow:
                                      TextOverflow.ellipsis, // Handle overflow
                                ),
                              ),
                              Container(
                                width:
                                    200, // Fixed width for single line of text
                                child: Text(
                                  state.diseasename,
                                  style: ktextstyle.copyWith(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize:
                                          13), // Adjust text style as needed
                                  maxLines:
                                      2, // Set the maximum number of lines
                                  overflow:
                                      TextOverflow.ellipsis, // Handle overflow
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image(
                                      height: 15,
                                      width: 10,
                                      image: AssetImage(
                                          "assets/images/Hand With a Pill.png")),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2.0),
                                    child: Container(
                                      width:
                                          200, // Fixed width for single line of text
                                      child: Text(
                                        "Deficiency ",
                                        style: ktextstyle.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontSize:
                                                13), // Adjust text style as needed
                                        maxLines:
                                            2, // Set the maximum number of lines
                                        overflow: TextOverflow
                                            .ellipsis, // Handle overflow
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border:
                                      Border.all(color: kdarkgreen, width: 2)),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CameraPage()));
                                  }, //Elevated button for  regenerate
                                  style: ElevatedButton.styleFrom(
                                      maximumSize: Size(139, 50),
                                      minimumSize: Size(80, 35),
                                      shadowColor: Colors.black,
                                      backgroundColor: kwhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                  child: Center(
                                    child: Text(
                                      "Re-generate",
                                      style: ktextstyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: kdarkgreen),
                                    ),
                                  )),
                            ),
                            ElevatedButton(
                                onPressed:
                                    () {}, //Elevated button for consult a doctor
                                style: ElevatedButton.styleFrom(
                                    maximumSize: Size(160, 54),
                                    minimumSize: Size(80, 35),
                                    shadowColor: Colors.black,
                                    backgroundColor: kdarkgreen,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                child: Center(
                                  child: Text(
                                    "Consult a doctor",
                                    style: ktextstyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: kwhite),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0, left: 5),
                        child: Text(
                          "Description",
                          style: ktextstyle.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, left: 15),
                        child: Text(state.description),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 5),
                        child: Text("Solution",
                            style: ktextstyle.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, left: 15, bottom: 10),
                        child: Text(state.solution),
                      ),
                      Container(
                        height: 70,
                        width: 307,
                        decoration: BoxDecoration(
                            color: Color(0xffF8FFE2),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: kdarkgreen)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, left: 8.0),
                              child: Text(
                                "Risk Life Prediction",
                                style: ktextstyle.copyWith(
                                    color: kdarkgreen, fontSize: 14),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, top: 5, right: 12.0),
                                child: SizedBox(
                                  height: 3,
                                  child: LinearProgressBar(
                                    maxSteps: 5,
                                    progressType:
                                        LinearProgressBar.progressTypeLinear,
                                    minHeight: 16,
                                    // Use Linear progress
                                    currentStep: int.parse(state.riskLevel),
                                    progressColor: kdarkgreen,
                                    backgroundColor: klightgrey,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, left: 8, right: 8, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, left: 5.0),
                                    child: Text(
                                      "low",
                                      style: ktextstyle.copyWith(
                                          color: kdarkgreen, fontSize: 12),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, left: 5.0),
                                    child: Text(
                                      "high",
                                      style: ktextstyle.copyWith(
                                          color: kdarkgreen, fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        }
        if (state is CameraLoading) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
            // Your CameraLoading UI
          );
        }

        if (state is CameraFailed) {
          print("camera error");
          return Scaffold(

              // Your CameraError UI
              );
        }
        return Scaffold(
            // Your Unknown state UI
            body: Text("this is default"));
      },
    );
  }
}



/*import 'package:farmer_app/Constants/Colors.dart';
import 'package:farmer_app/Constants/Text.dart';
import 'package:farmer_app/Screens/LoginPage.dart';
import 'package:farmer_app/bloc/Camera_bloc/camera_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    pickImage(); // Pick an image when the page is loaded
  }

  Future<void> pickImage() async {
    try {
      // Use ImagePicker to pick an image from the camera
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        setState(() {
          _imageFile = File(image.path);
        });
        // Optionally, perform additional actions with the selected image
        print('Image captured: ${image.path}');
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraBloc, CameraState>(
      builder: (context, state) {
        if (state is CameraSuccessfull) {
          return Scaffold(
              backgroundColor: kwhite,
              appBar: AppBar(
                  backgroundColor: kwhite,
                  title: const Text(
                    'Report of analysis',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  )),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        //Row for image and the words.
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 90, // Specify width
                            height: 102, // Specify height
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors
                                  .grey[200], // Optional: background color
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                _imageFile!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width:
                                    200, // Fixed width for single line of text
                                child: Text(
                                  "Phosphorus Deficiency in Leaf",
                                  style: ktextstyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: kdarkgreen,
                                      fontSize:
                                          16), // Adjust text style as needed
                                  maxLines:
                                      2, // Set the maximum number of lines
                                  overflow:
                                      TextOverflow.ellipsis, // Handle overflow
                                ),
                              ),
                              Container(
                                width:
                                    200, // Fixed width for single line of text
                                child: Text(
                                  "Phosphorus Deficiency ",
                                  style: ktextstyle.copyWith(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize:
                                          12), // Adjust text style as needed
                                  maxLines:
                                      2, // Set the maximum number of lines
                                  overflow:
                                      TextOverflow.ellipsis, // Handle overflow
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image(
                                      height: 15,
                                      width: 10,
                                      image: AssetImage(
                                          "assets/images/Hand With a Pill.png")),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2.0),
                                    child: Container(
                                      width:
                                          200, // Fixed width for single line of text
                                      child: Text(
                                        "Deficiency ",
                                        style: ktextstyle.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontSize:
                                                12), // Adjust text style as needed
                                        maxLines:
                                            2, // Set the maximum number of lines
                                        overflow: TextOverflow
                                            .ellipsis, // Handle overflow
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border:
                                      Border.all(color: kdarkgreen, width: 2)),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                  }, //Elevated button for  regenerate
                                  style: ElevatedButton.styleFrom(
                                      maximumSize: Size(139, 50),
                                      minimumSize: Size(80, 35),
                                      shadowColor: Colors.black,
                                      backgroundColor: kwhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                  child: Center(
                                    child: Text(
                                      "Re-generate",
                                      style: ktextstyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: kdarkgreen),
                                    ),
                                  )),
                            ),
                            ElevatedButton(
                                onPressed:
                                    () {}, //Elevated button for consult a doctor
                                style: ElevatedButton.styleFrom(
                                    maximumSize: Size(160, 54),
                                    minimumSize: Size(80, 35),
                                    shadowColor: Colors.black,
                                    backgroundColor: kdarkgreen,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                child: Center(
                                  child: Text(
                                    "Consult a doctor",
                                    style: ktextstyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: kwhite),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0, left: 5),
                        child: Text(
                          "Description",
                          style: ktextstyle.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, left: 15),
                        child: Text(
                          '• Vital Macronutrient: Phosphorus (P) is essential for plant growth and development, being a key component of DNA, RNA, and ATP.\n\n'
                          '• Energy Transfer: Crucial for energy transfer processes, phosphorus is a major part of ATP, which powers various plant functions.\n\n'
                          '• Photosynthesis: Plays a key role in photosynthesis by aiding in the formation of ATP, necessary for converting light energy into chemical energy.\n\n'
                          '• Nutrient Movement: Facilitates nutrient movement within the plant by supporting root development and nutrient absorption.',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 5),
                        child: Text("Solution",
                            style: ktextstyle.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, left: 15, bottom: 10),
                        child: Text(
                            "Apply Phosphorus Fertilizer: Use phosphorus-rich fertilizers like superphosphate or organic options like bone meal. Adjust Soil pH: Ensure soil pH is between 6.0-7.5 for optimal phosphorus availability. Improve Soil Structure: Aerate soil and add organic matter to enhance root growth and nutrient absorption."),
                      ),
                      Container(
                        height: 70,
                        width: 307,
                        decoration: BoxDecoration(
                            color: Color(0xffF8FFE2),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: kdarkgreen)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, left: 8.0),
                              child: Text(
                                "Risk Life Prediction",
                                style: ktextstyle.copyWith(
                                    color: kdarkgreen, fontSize: 14),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, top: 5, right: 12.0),
                                child: SizedBox(
                                  height: 3,
                                  child: LinearProgressBar(
                                    maxSteps: 5,
                                    progressType:
                                        LinearProgressBar.progressTypeLinear,
                                    minHeight: 16,
                                    // Use Linear progress
                                    currentStep: 4,
                                    progressColor: kdarkgreen,
                                    backgroundColor: klightgrey,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, left: 8, right: 8, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, left: 5.0),
                                    child: Text(
                                      "low",
                                      style: ktextstyle.copyWith(
                                          color: kdarkgreen, fontSize: 12),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, left: 5.0),
                                    child: Text(
                                      "high",
                                      style: ktextstyle.copyWith(
                                          color: kdarkgreen, fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        } else if (state is CameraInitial) {
          return Scaffold(
            appBar: AppBar(title: const Text('Image Picker')),
            body: Center(
              child: _imageFile != null
                  ? Image.file(_imageFile!)
                  : const Text('No image captured'),
            ),
          );
        } else if (state is CameraLoading) {
          return Scaffold(
            appBar: AppBar(title: const Text('Image Picker')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: AppBar(title: const Text('Image Picker')),
          body: const Center(child: Text('Unknown state')),
        );
      },
    );
  }
}
*/