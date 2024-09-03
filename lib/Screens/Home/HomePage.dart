import 'package:farmer_app/Constants/Colors.dart';
import 'package:farmer_app/Constants/Text.dart';
import 'package:farmer_app/Screens/Community/Community.dart';
import 'package:farmer_app/Screens/Home/Community_button.dart';
import 'package:farmer_app/Screens/Home/Diagonse_button.dart';
import 'package:farmer_app/Screens/Plant_diagonse/plant_types.dart';
import 'package:farmer_app/bloc/bloc/auth_bloc.dart';
import 'package:farmer_app/bloc/mic_bloc/mic_bloc.dart';
import 'package:farmer_app/generated/l10n.dart';
import 'package:farmer_app/widgets/bottomNavigatorBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



bool islistening = false;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // WebViewController webcontroll = WebViewController()
  //  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //  ..canGoBack()
  //  ..canGoForward()
  //  ..setNavigationDelegate(NavigationDelegate(onProgress: (progress) {
  //    CircularProgressIndicator();
  //  },))

  //  ..setBackgroundColor(Colors.white)
  //  ..setOnScrollPositionChange((change) {print("nothing");})

  //  ..loadRequest(Uri.parse('https://www.google.com/maps'));

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          islistening = !islistening;
          islistening
              ? context.read<MicBloc>().add(ListenNow())
              : context.read<MicBloc>().add(StopListening());
        },
        child: Image.asset(
          "assets/icons_assets/speak.png",
          color: klightgreen,
        ),
        tooltip: "longpress",
        focusColor: kdarkgreen,
        splashColor: kdarkgreen,
        backgroundColor: kdarkgreen,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(60.0), // Customize the radius as needed
        ),
      ),
      bottomNavigationBar: BlocBuilder<MicBloc, MicState>(
        builder: (context, state) {
          if (state is Listening) {
            return BottomNavigatorBar(
              items: [
                BottomNavItem(
                  // widget: Image.asset("assets/gif/audio.gif"),
                  widget: Text(
                    S.of(context).listening,
                    style:
                        ktextstyle.copyWith(fontSize: 16, color: Colors.white),
                  ),
                  //label: "Profile",
                  onTap: () {
                    // Handle profile button tap
                  },
                ),
                // Add more items as needed
              ],
            );
          }
          // if(state is MicInitial){
          //   return  BottomNavigatorBar(
          //     items: [
          //       BottomNavItem(
          //         widget:Image.asset("assets/icons_assets/home.png") ,
          //         //label: "Home",
          //         onTap: () {
          //           // Handle home button tap
          //         },
          //       ),
          //       BottomNavItem(
          //         widget:Image.asset("assets/icons_assets/community.png") ,
          //         //label: "Profile",
          //         onTap: () {
          //           // Handle profile button tap
          //         },
          //       ),
          //       // Add more items as needed
          //     ],
          //   );
          // }
          return BottomNavigatorBar(
            items: [
              BottomNavItem(
                widget: Image.asset("assets/icons_assets/home.png"),
                //label: "Home",
                onTap: () {
                  // Handle home button tap
                },
              ),
              BottomNavItem(
                widget: Image.asset("assets/icons_assets/community.png"),
                //label: "Profile",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CommunityPage()));
                },
              ),
              // Add more items as needed
            ],
          );
        },
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if(state is FetchingUserInformation){
            return Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height:8),
                Text("Loading...",style: TextStyle(fontSize: 16),),
              ],
              ),);
          }
          return SingleChildScrollView(
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
                        style: ktextstyle.copyWith(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "great ",
                        style: ktextstyle.copyWith(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "day",
                        style: ktextstyle.copyWith(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  const Community_button(),
                  SizedBox(height: 24),
                  Text(
                    "Diagonse",
                    style: ktextstyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w600),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlantType()));
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
                    style: ktextstyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  // Container(
                  //   height: 200,
                  //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)), // Set a specific height for the WebView
                  //   width: double.infinity, // Expand to fill available width
                  //   child: WebViewWidget(controller: webcontroll,
                  // ),

                  // ),
                  // Container(
                  //   height: 200,
                  //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)), // Set a specific height for the WebView
                  //   width: double.infinity, // Expand to fill available width
                  //   child: NearbyVeterinariansMap(),

                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
