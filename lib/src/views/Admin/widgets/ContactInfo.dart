import 'package:flutter/material.dart';

class ContactInfo extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isMobile;
  final Color iconColor; // New parameter for icon color

  ContactInfo({
    required this.icon,
    required this.text,
    this.isMobile = false,
    this.iconColor = Colors.black, // Default color is black
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon,
            size: isMobile ? 16 : 20,
            color: iconColor), // Use the iconColor here
        SizedBox(width: 10),
        Text(text, style: TextStyle(fontSize: isMobile ? 12 : 16)),
      ],
    );
  }
}