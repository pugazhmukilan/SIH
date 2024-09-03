import 'package:farmer_app/Constants/Text.dart';
import 'package:farmer_app/Screens/Home/Community_button.dart';
import 'package:farmer_app/Screens/Home/Diagonse_button.dart';
import 'package:farmer_app/Screens/Home/maps_Page.dart';
import 'package:farmer_app/Screens/Plant_diagonse/plant_types.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WebViewController webcontroll = WebViewController()
   ..setJavaScriptMode(JavaScriptMode.unrestricted)
   ..canGoBack()
   ..canGoForward()
   ..setNavigationDelegate(NavigationDelegate(onProgress: (progress) {
     CircularProgressIndicator();
   },))
   
  
   ..setBackgroundColor(Colors.white)
   ..setOnScrollPositionChange((change) {print("nothing");})

   ..loadRequest(Uri.parse('https://www.google.com/maps'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Name",
          style: ktextstyle.copyWith(fontSize: 16),
        ),
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 5),
          child: CircleAvatar(
            radius: 25, // Updated radius for better visibility
             // Example image
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Action for settings button
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
  padding: const EdgeInsets.only(bottom: 20.0), // Add padding to move it up
  child: Container(
    height: 50,
    color: Colors.transparent,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add padding to the sides
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.green,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distributes space evenly
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home, color: Colors.white),
                    Text("Home", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search, color: Colors.white),
                    Text("Search", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, color: Colors.white),
                    Text("Profile", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
),

      
      
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Have a ",
                    style: ktextstyle.copyWith(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "great ",
                    style: ktextstyle.copyWith(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "day",
                    style: ktextstyle.copyWith(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16),
              const Community_button(),
              SizedBox(height: 24),
              Text(
                "Diagonse",
                style: ktextstyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  diagonse_Button(
                    imagepath: "assets/images/plant_image.png",
                    text: "Plant",
                    press: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PlantType()));
                    },
                  ),
                  SizedBox(width: 8),
                  diagonse_Button(
                    imagepath: "assets/images/animal_image.png",
                    text: "Animals",
                    press: () {},
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                "Doctors near by",
                style: ktextstyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              // Container(
              //   height: 200,
              //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)), // Set a specific height for the WebView
              //   width: double.infinity, // Expand to fill available width
              //   child: WebViewWidget(controller: webcontroll,
              // ),
      
    
              // ),
              Container(
                height: 200,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)), // Set a specific height for the WebView
                width: double.infinity, // Expand to fill available width
                child: NearbyVeterinariansMap(),
      
    
              ),
            ],
          ),
        ),
      ),
    );
  }
}
