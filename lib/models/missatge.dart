import 'package:cloud_firestore/cloud_firestore.dart';

class Missatge {

  final String idAuthor;
  final String emialAuthor;
  final String idReceptor;
  final String mensaje;
  final Timestamp timestamp;

  Missatge({
    required this.idAuthor,
    required this.emialAuthor,
    required this.idReceptor,
    required this.mensaje,
    required this.timestamp,
  });

  Map<String, dynamic> devuelveMensaje() {
    return {
      "idAuthor": idAuthor,
      "emialAuthor": emialAuthor,
      "idReceptor": idReceptor,
      "mensaje": mensaje,
      "timestamp": timestamp,
    };
  }
}