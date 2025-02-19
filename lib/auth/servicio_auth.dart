import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServicioAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firesotore = FirebaseFirestore.instance;

  //Hacer registro
  Future<UserCredential> registroConEmailPassword(
      String email, password) async {

    try {
      UserCredential credencialUsuario =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _firesotore.collection("Usuarios").doc(credencialUsuario.user!.uid).set({
        "uid": credencialUsuario.user!.uid,
        "email": email,
        "nombre": "",
      });

      return credencialUsuario;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}
