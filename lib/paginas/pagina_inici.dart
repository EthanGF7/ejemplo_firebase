import 'package:ejemplo_firebase/auth/servei_auth.dart';
import 'package:ejemplo_firebase/chat/servei_chat.dart';
import 'package:ejemplo_firebase/componetes/item_usuari.dart';
import 'package:ejemplo_firebase/paginas/pagina_chat.dart';
import 'package:flutter/material.dart';

class PaginaInici extends StatefulWidget {
  const PaginaInici({super.key});

  @override
  State<PaginaInici> createState() => _PaginaIniciState();
}

class _PaginaIniciState extends State<PaginaInici> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(ServeriAuth().getUsuariActual()!.email!),
        actions: [
          IconButton(
            onPressed: () {
              ServeriAuth().ferLogout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: ServeiChat().getUsarios(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error amb el snapshot.");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Carregant dades...");
          }

          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (dadesUsuari) => _construeixItemUsuari(dadesUsuari,context))
                .toList(),
          );
        },
      ),
    );
  }

  Widget _construeixItemUsuari(Map<String, dynamic> dadesUsari, BuildContext context) {
    print(dadesUsari["email"]);
    if (dadesUsari["email"] == ServeriAuth().getUsuariActual()!.email) {
      return Container();
    }
    return ItemUsari(
      emailUsario: dadesUsari["email"],
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaginaChat(idReceptor: dadesUsari["uid"],),
          ),
        );
      },
    );
  }
}