import 'package:ejemplo_firebase/firebase_options.dart';
import 'package:ejemplo_firebase/paginas/pagina_registrro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaginaResgistro(),
        );

  }
}

/*
1) Tener el Node.js instalado
  - Cuando este acabada la instalacion podemos comprabar si se instalo correctamente con el comando node -v y npm -v
2) Ir a la web de firebase y clicar a "Go to console"
  - Tener en cuenta que cuenta de google estamos utilizando
3) Desde la consola de Firebase, clicar en "Añadir proyecto"
  - Darle un nombre al proyecto y clicar en "Continuar"
  - Desactivar la opcion de Google Analytics y clicar en "Crear proyecto"
4) Vamos al menu Compilacion y habilitamos:
  - Autenticacion y Firestore Database
5) En un cmd, por ejemplo el del VS Code, ejecutamos el comando npm install -g firebase-tools
  - Con este comando instalamos la herramienta de Firebase
6) flutter pub get global activate flutterfire_cli
  - Con este comando instalamos la herramienta de Flutter
*/