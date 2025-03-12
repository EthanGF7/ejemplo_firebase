import 'package:flutter/material.dart';

class BotoAuth extends StatelessWidget {
  final String text;
  final Function() onTap;

  const BotoAuth({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 70, 52, 236),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 3
            ),
          ),
        ),
      ),
    );
  }
}
