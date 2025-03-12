import 'package:flutter/material.dart';

class ItemUsari extends StatelessWidget {
  final String emailUsario;
  final Function() onTap;
  const ItemUsari({
    super.key,
    required this.emailUsario,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(emailUsario),
        ),
      ),
    );
  }
}