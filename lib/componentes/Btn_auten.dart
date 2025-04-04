import 'package:flutter/material.dart';

class BtnAuten extends StatelessWidget {

  final String Txt;
  final Function() onTap;
  const BtnAuten({super.key, required this.Txt, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(175, 54, 136, 244),
        ),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Text(
            Txt,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
