import 'package:ejemplo_firebase/auth/login_o_registre.dart';
import 'package:ejemplo_firebase/paginas/pagina_inici.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PortalAuth extends StatelessWidget {
  const PortalAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot) {

          if(snapshot.hasData){
            return const PaginaInici();
          } else {
            return const LoginORegistre();
          }
        },
      ),
    );
  }
}