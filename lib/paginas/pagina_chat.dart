import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejemplo_firebase/auth/servei_auth.dart';
import 'package:ejemplo_firebase/chat/servei_chat.dart';
import 'package:ejemplo_firebase/componetes/bombolla_missatge.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaginaChat extends StatefulWidget {
  final String idReceptor;

  const PaginaChat({
    super.key,
    required this.idReceptor,
  });

  @override
  State<PaginaChat> createState() => _PaginaChatState();
}

class _PaginaChatState extends State<PaginaChat> {
  final TextEditingController tecMensaje = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  FocusNode teclatMobil = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    teclatMobil.addListener(() {
      Future.delayed(const Duration(milliseconds: 500), () {
      ferScrollCapAvall();
    });
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      ferScrollCapAvall();
    });
  }

  void ferScrollCapAvall() {
    _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Sala chat"),
      ),
      body: Column(
        children: [
          //zona mensajes
          _crearZonaMostrarMissatges(),

          //zona enviar mensaje
          _crearZonaEnviarMensaje(),
        ],
      ),
    );
  }

  Widget _crearZonaMostrarMissatges() {
    return Expanded(
      child: StreamBuilder(
        stream: ServeiChat().getMissatges(
            ServeriAuth().getUsuariActual()!.uid, widget.idReceptor),
        builder: (context, snapshot) {
          // En cas d'error:
          if (snapshot.hasError) {
            return const Text("Error al carregar missatges.");
          }

          //En cas d'estar carregant dades:
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Carregant missatges...");
          }

          // Retornar dades (Missatges):
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((documento) => _construirItemMissatge(documento))
                .toList(),
          );
        },
      ),
    );
  }

  Widget _construirItemMissatge(DocumentSnapshot documentoSnapshot) {
    Map<String, dynamic> data =
        documentoSnapshot.data() as Map<String, dynamic>;

    return BombollaMissatge(
        missatge: data["mensaje"], idAutor: data["idAuthor"]);
    //Text(data["mensaje"]); <--- Aixo també serveix
  }

  Widget _crearZonaEnviarMensaje() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: tecMensaje,
            decoration: InputDecoration(
              hintText: "Escribe un mensaje...",
              filled: true,
              fillColor: Colors.indigo[400],
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: enviarMensaje,
          icon: const Icon(Icons.send),
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.indigo[300])),
        )
      ]),
    );
  }

  void enviarMensaje() {
    if (tecMensaje.text.isNotEmpty) {
      ServeiChat().enviarMensaje(
        widget.idReceptor,
        tecMensaje.text,
      );

      tecMensaje.clear();
      
    }
  }
}
