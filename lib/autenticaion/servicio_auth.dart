import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServicioAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obtener el usuario actual
  User? getUsuarioActual() {
    return _auth.currentUser;
  }

  // Cerrar sesión
  Future<void> hacerlogout() async {
    return await _auth.signOut();
  }

  // Login con Email y Password
  Future<String?> loginEmailPass(String email, String password) async {
    try {
      UserCredential crendencialUsuario = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      // Verificar si el usuario existe en la colección "usuarios"
      final QuerySnapshot querySnapshot = await _firestore
          .collection("usuarios")
          .where("email", isEqualTo: email)
          .get();

      if (querySnapshot.docs.isEmpty) {
        _firestore.collection("usuarios").doc(crendencialUsuario.user!.uid).set({
          "uid": crendencialUsuario.user!.uid,
          "email": email,
          "nom": "",
        });
      }

      return null;
    } on FirebaseAuthException catch (e) {
      return "Error: ${e.message}";
    }
  }

  // Registro con Email y Password
  Future<String?> regristroEmailPass(String email, password) async {
    try {
      UserCredential crendencialUsuario = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      _firestore.collection("usuarios").doc(crendencialUsuario.user!.uid).set({
        "uid": crendencialUsuario.user!.uid,
        "email": email,
        "nom": "",
      });

      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return "Ya hay un usuario con este email";
        case "invalid-email":
          return "Email no válido";
        case "operation-not-allowed":
          return "Email y/o Password no habilitados";
        case "weak-password":
          return "Hace falta una contraseña más robusta";
        default:
          return "Error ${e.message}";
      }
    } catch (e) {
      return "Error $e";
    }
  }
}