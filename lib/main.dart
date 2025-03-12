import 'package:ejemplo_firebase/auth/portal_auth.dart';
import 'package:ejemplo_firebase/auth/portal_auth.dart';
import 'package:ejemplo_firebase/firebase_options.dart';
import 'package:ejemplo_firebase/paginas/pagina_login.dart';
import 'package:ejemplo_firebase/paginas/pagina_registro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MainApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner : false,
      home: Scaffold(
        body: PortalAuth()
      ),
    );
  }
}


/*
  1) Tenir Node.js instalat.
    - En acabar, es pot comprobar fent:
        node -v 
        npm -v

2) Anar a la web de Firebase i clicar a "Go to console".
    - Tenir en compte amb quin compte de Google.

3) Des de la consola de Firebase, creem un projecte de 
  Firebase.

4) Anem al menú Compilación i habilitem: 
    Authentication i Firestore Database

5) En una cmd, per exemple la del VS Code, fem:
    npm install -g firebase-tools
    (això instala les Firebase tools al dispositiu)
    Pot fer falta fer abans:
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

6) flutter pub global activate flutterfire_cli
    o dart pub global activate flutterfire_cli

7) flutterfire configure
    - Seleccionem el projecte de Firebase
        amb el que el volem vincular.
    - Deixem seleccionats només els dispositius amb els que 
        volem que funcioni l'aplicació (en aquest cas android i web).
    
    - Si no detecta la comanda flutterfire configure, és que s'ha 
        d'afegir flutterfire al path (al path de l'usuari de les 
        variables d'entorn).
    
    - La ruta per defecte és:
        C:\Users\<nom_usuari>\AppData\Local\Pub\Cache\bin
    
8) Instal·lem les dependències de Firebase que vulguem utilitzar:
    - flutter pub add firebase_core
    - flutter pub add firebase_auth
    - flutter pub add cloud_firestore
    (amb això, marxen els errors de firebase_options.dart)

9)  Si el repositori és públic: afegir al .gitignore els arxius 
      /lib/firebase_options.dart i 
      /firebase.json (o firebase.json), 
    que contenen les claus d'accés al servei de Firebase.
      - Fer-ho abans de fer el commit.

*/