import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  final InputDecoration decoration;
  final TextEditingController controller;
  final TextStyle textStyle;  // Add textStyle to accept text color customization

  const TextFields({
    super.key,
    required this.decoration,
    required this.controller,
    required this.textStyle,  // Accept TextStyle as a parameter
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        controller: controller,
        decoration: decoration,
        style: textStyle,  // Apply the text style to the TextField
        cursorColor: Colors.green,  // Set cursor color
      ),
    );
  }
}
