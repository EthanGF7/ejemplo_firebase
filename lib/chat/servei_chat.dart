import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejemplo_firebase/models/missatge.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServeiChat {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsarios() {
    return _firestore.collection("Usuaris").snapshots().map((event) {
      return event.docs.map((documento) {
        return documento.data();
      }).toList();
    });
  }

  Future<void> enviarMensaje(String idReceptor, String mensaje) async {
    //La sala de chat es entre dos usuarios.
    //La creamos  a partir de las ids de los usuarios.
    String idUsarioActual = _auth.currentUser!.uid;
    String emialUsarioActual = _auth.currentUser!.email!;
    Timestamp timestamp = Timestamp.now();

    Missatge nuevoMensaje = Missatge(
      idAuthor: idUsarioActual,
      emialAuthor: emialUsarioActual,
      idReceptor: idReceptor,
      mensaje: mensaje,
      timestamp: timestamp,
    );

    List<String> idUsarios = [idUsarioActual, idReceptor];
    //ordenamos las ids para que siempre sea igual sin
    //importar el usario que la abra.
    idUsarios.sort();

    String idSalaChat = idUsarios.join("_");

    await _firestore
        .collection("SalasChats")
        .doc(idSalaChat)
        .collection("Mensajes")
        .add(
          nuevoMensaje.devuelveMensaje(),
        );
  }

  Stream<QuerySnapshot> getMissatges(String idUsarioActual, String idReceptor) {
    // Creem el idSalaChat, igual que quan guardem els missatges.
    List<String> idsUsaris = [idUsarioActual, idReceptor];
    idsUsaris.sort();
    String idSalaChat = idsUsaris.join("_");

    // Retornem els missatges d'aquesta SalaChat
    return _firestore
        .collection("SalasChats")
        .doc(idSalaChat)
        .collection("Mensajes")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
