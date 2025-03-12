import 'package:flutter/material.dart';

class TextfieldAuth extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;

  const TextfieldAuth({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.hintText,
    });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 30),
      child: TextField(
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white), 
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.indigo)),
          fillColor: Colors.indigo[300], filled: true
        ),
      ),
      
    );
  }
}