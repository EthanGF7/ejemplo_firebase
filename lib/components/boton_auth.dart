import 'package:flutter/material.dart';

class BotonAuth extends StatelessWidget {
  final String texto;
  final Function() onTap;
  const BotonAuth({
    super.key,
    required this.texto,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 244, 111, 54),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Text(
            texto,
            style: TextStyle(
              color: Colors.orange[100],
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
            ),
          ),
        ),
      ),
    );
  }
}