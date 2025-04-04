import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejemplo_firebase/autenticaion/servicio_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BurbujaMensaje extends StatelessWidget {
  final String mensaje;
  final String idAutor;
  final Timestamp Fecha;

  const BurbujaMensaje({
    super.key,
    required this.mensaje,
    required this.idAutor,
    required this.Fecha,
  });

  @override
  Widget build(BuildContext context) {
    DateTime fechaMensaje = Fecha.toDate();
    DateTime ahora = DateTime.now();

    // Calcular diferència de dies
    int diferenciaDias = ahora.difference(
      DateTime(fechaMensaje.year, fechaMensaje.month, fechaMensaje.day),
    ).inDays;

    // Format de la data
    String textoFecha;
    if (diferenciaDias == 0) {
      textoFecha = DateFormat('HH:mm').format(fechaMensaje);
    } else if (diferenciaDias == 1) {
      textoFecha = 'Fa 1 dia';
    } else {
      textoFecha = 'Fa $diferenciaDias dies';
    }

    // Identificar si és el missatge de l'usuari actual
    final usuarioActual = ServicioAuth().getUsuarioActual();
    final esUsuarioActual = usuarioActual != null && idAutor == usuarioActual.uid;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Align(
        alignment: esUsuarioActual ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              esUsuarioActual ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: BoxDecoration(
                color: esUsuarioActual
                    ? const Color.fromARGB(255, 166, 250, 201)
                    : const Color.fromARGB(255, 255, 224, 140), // Color groc per altres
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                mensaje,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                textoFecha,
                style: TextStyle(
                  fontSize: 11,
                  color: esUsuarioActual
                      ? const Color.fromARGB(255, 80, 185, 124)
                      : const Color.fromARGB(255, 160, 160, 100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}