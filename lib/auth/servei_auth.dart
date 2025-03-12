import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServeriAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  User? getUsuariActual() {
    return _auth.currentUser;
  }

  Future<void> ferLogout() async{
    return await _auth.signOut();
  }
  
  Future<String?> loginEmailPassword(String email, password) async{

    try {

      UserCredential credencialUsuari = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );

      final QuerySnapshot querySnapshot = await _firestore
      .collection("Usuaris")
      .where("email", isEqualTo: email)
      .get();

      if (querySnapshot.docs.isEmpty) {
        _firestore.collection("Usuaris").doc(credencialUsuari.user!.uid).set({
          "uid": credencialUsuari.user!.uid,
          "email": email,
          "nom": "",
        });
      }

      return null;

    } on FirebaseAuthException catch(e) {
      return "Error: ${e.message}";
    }
  }
  
  Future<String?> registreEmailPassword(String email, password) async {
    
    
    try {
      UserCredential credencialusuari = await _auth
        .createUserWithEmailAndPassword(
          email: email, 
          password: password
        );

        _firestore.collection("Usuaris").doc(credencialusuari.user!.uid).set({
          "uid": credencialusuari.user!.uid,
          "email": email,
          "nom": "",
        });

        return null;
    } on FirebaseAuthException catch (e) {
      
      switch(e.code){
        case "email-already-in-use":
          return "Ja hi ha un usuari amb aquest correo electronic.";
        
        case "invalid-email":
          return "Aquest correo electronic es invalid, torna-ho provar.";

        case "operation-not-allowed":
          return "El correo o la contraseña no habilitats.";

        case "weak-password":
          return "La contrasenya es debíl, prova una més forta.";
        
        default:
          return "Error ${e.message}";
      }

    } catch (e) {

      return "Error $e";
    }

    
  }
}
