import 'package:flutter/material.dart';

class PlantWidget extends StatelessWidget {
  final int index;
  final List<String> filteredPlantNames;
  final String? imagePath; // Optional image path

  PlantWidget({
    super.key,
    required this.index,
    required this.filteredPlantNames,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Optional Image with Overlay
          if (imagePath != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath!,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          // Gradient Overlay
          if (imagePath != null)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          // Plant Name
          Center(
            child: Text(
              filteredPlantNames[index],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Ensure text is visible over the gradient
              ),
            ),
          ),
        ],
      ),
    );
  }
}
