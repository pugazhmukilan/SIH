import 'package:farmer_app/Constants/Text.dart';
import 'package:farmer_app/Screens/Community/Community.dart';
import 'package:flutter/material.dart';

class Community_button extends StatelessWidget {
  const Community_button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap :(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> CommunityPage()));
        },
      child: Container(
        
        height:77,
        width:double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image:AssetImage('assets/images/community_bg.png'), // Replace with your image path
      fit: BoxFit.cover,)
        ),
        
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Image.asset("assets/icons_assets/community_logo.png"),
              SizedBox(width:16),
              Text("community",style:ktextstyle.copyWith(fontSize: 15)),
            ],
          ),
        ),
      
      ),
    );
  }
}
