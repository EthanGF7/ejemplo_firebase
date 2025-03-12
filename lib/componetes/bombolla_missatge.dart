import 'package:ejemplo_firebase/auth/servei_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BombollaMissatge extends StatelessWidget {
  final String missatge;
  final String idAutor;
  const BombollaMissatge({
    super.key,
    required this.missatge,
    required this.idAutor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
      child: Align(
        alignment: idAutor == ServeriAuth().getUsuariActual()!.uid
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: idAutor == ServeriAuth().getUsuariActual()!.uid
                ? Colors.indigo[300]
                : Colors.indigoAccent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              missatge,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
