import 'package:farmer_app/Constants/Colors.dart';
import 'package:flutter/material.dart';

class BottomNavigatorBar extends StatelessWidget {
  final List<BottomNavItem> items;

  const BottomNavigatorBar({
    super.key,
    this.items = const [], // Make items optional
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70.0),
          child: Container(
            width: 150,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: kdarkgreen,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: items.map((item) => Expanded(
                  child: GestureDetector(
                    onTap: item.onTap,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                            item.widget, // Use the widget directly if provided
                        ],
                      ),
                    ),
                  ),
                )).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavItem {
  final Widget widget; // Optional widget parameter
  final VoidCallback? onTap; // Optional onTap callback

  BottomNavItem({
    required this.widget,
    this.onTap,
  });
}
