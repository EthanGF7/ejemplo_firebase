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
    // Validación de Fecha
    DateTime fechaMensaje = Fecha.toDate();
    DateTime ahora = DateTime.now();
    int diferenciaDias = ahora.difference(fechaMensaje).inDays;

    String textoFecha;
    try {
      if (diferenciaDias == 0) {
        textoFecha = DateFormat('HH:mm').format(fechaMensaje);
      } else if (diferenciaDias == 1) {
        textoFecha = 'hace 1 día';
      } else {
        textoFecha = 'hace $diferenciaDias días';
      }
    } catch (e) {
      textoFecha = "Fecha no válida";
      print("Error formateando la fecha: $e");
    }

    final usuarioActual = ServicioAuth().getUsuarioActual();
    final esUsuarioActual = usuarioActual != null && idAutor == usuarioActual.uid;

    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
      child: Align(
        alignment: esUsuarioActual ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: esUsuarioActual ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    decoration: BoxDecoration(
                      color: esUsuarioActual
                          ? const Color.fromARGB(255, 166, 250, 201)
                          : const Color.fromARGB(255, 181, 213, 218),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      mensaje,
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: esUsuarioActual ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Text(
                  textoFecha,
                  style: TextStyle(
                    color: esUsuarioActual
                        ? const Color.fromARGB(255, 80, 185, 124)
                        : const Color.fromARGB(255, 104, 201, 216),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}