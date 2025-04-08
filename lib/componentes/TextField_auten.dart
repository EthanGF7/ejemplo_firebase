import 'package:flutter/material.dart';

class TxtFld_auten extends StatelessWidget {
  final TextEditingController controller;
  final bool  obscureTxt;
  final String hintTxt;
  const TxtFld_auten({super.key, required this.controller, required this.hintTxt, required this.obscureTxt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        cursorColor: const Color.fromARGB(255, 0, 119, 255),
        style: const TextStyle(color: Colors.black),
        controller: controller,
        obscureText: obscureTxt,
        decoration: InputDecoration(
          hintText: hintTxt,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 44, 69, 82),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 76, 0, 255)
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 0, 92, 197),
            ),
          ),
          fillColor: const Color.fromARGB(184, 126, 222, 252),
          filled: true,
        ),
      ),
    );
  }
}