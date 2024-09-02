import 'package:farmer_app/Constants/Text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Name",style: ktextstyle.copyWith(fontSize: 16),),
        
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left:20.0,right:5),
          child: CircleAvatar(
            radius: 5,
          ),
        ),
        
        actions: [
          IconButton(
           onPressed: (){
            
           }, icon: Icon(Icons.settings),)
        ],
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text("Have a ",style: ktextstyle.copyWith(fontSize: 23,fontWeight: FontWeight.bold),),
                  Text("great ",style: ktextstyle.copyWith(fontSize: 23,fontWeight: FontWeight.bold),),
                  Text("day",style: ktextstyle.copyWith(fontSize: 23,fontWeight: FontWeight.bold),),
                ],
              ),
            
              SizedBox(height:16),

              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: BoxDecoration(image: DecorationImage(
                  image: AssetImage('assets/images/community_bg.png'),
                  fit: BoxFit.cover, // Options include cover, fill, fitWidth, fitHeight, etc.
                ),),
                  child: Stack(
                    children: [
                      Positioned(
                        //top should be mid
                        top: 10,
                        left: 0,
                  
                        child: Row(
                        children: [
                          Image.asset("assets/icons_assets/community_logo.png",)
                        ],
                      ))
                    ],
                  ),
                ),
              )
            
            ],
          ),
        ),
      ),
    
    );
  }
}