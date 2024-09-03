
import 'package:flutter/material.dart';

class diagonse_Button extends StatelessWidget {
  final String imagepath;
  final String text;
  final VoidCallback press;
  const diagonse_Button({
    super.key,
    required this.imagepath,
    required this.text,
    required this.press,


  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex:1,
      child: GestureDetector(
        onTap: press,
        child: Container(
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagepath), // Replace with your image path
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 214, 214, 214), // Background color in case the image fails to load
            ),
            child: Stack(
              children: [
                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.5), Colors.black.withOpacity(0)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(10), // Match the border radius of the container
                  ),
                ),
                // Text widget
                Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
      )
    
    );
  }
}