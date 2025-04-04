import 'package:flutter/material.dart';

class ItemUsuario extends StatelessWidget {
  final Function()? onTap;
  final String emailUsuaio;

  const ItemUsuario({super.key, required this.emailUsuaio, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 140, 191, 233),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(emailUsuaio),
        ),
        ),
    );
  }
}