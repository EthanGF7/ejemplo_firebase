import 'package:flutter/material.dart';

class ItemUsuari extends StatelessWidget {
  final String emailUsuari;
  final Function() onTap;

  const ItemUsuari({super.key, required this.emailUsuari, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber[200],
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(emailUsuari),
        )
      ),
    );
  }
}