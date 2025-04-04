import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejemplo_firebase/autenticaion/servicio_auth.dart';
import 'package:ejemplo_firebase/chat/servicio_chat.dart';
import 'package:ejemplo_firebase/componentes/BurjMensaje.dart';
import 'package:flutter/material.dart';

class Paginachat extends StatefulWidget {
  final String idReceptor;
  const Paginachat({super.key, required this.idReceptor});

  @override
  State<Paginachat> createState() => _PaginachatState();
}

class _PaginachatState extends State<Paginachat> {
  final TextEditingController tecMensaje = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  FocusNode Teclado = FocusNode();

  @override
  void initState() {
    super.initState();

    Teclado.addListener(() {
      Future.delayed(const Duration(milliseconds: 500), () {
        hacerScrollAbajo();
      });
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      hacerScrollAbajo();
    });
  }

  void hacerScrollAbajo() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 100,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 245, 250), // color de fons com la imatge
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 202, 174, 238),
        title: Text(
          ServicioAuth().getUsuarioActual()?.email ?? "Chat",
          style: const TextStyle(color: Colors.black87),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          _crearZonaMostarMensajes(),
          _crearZonaEscribirMensajes(),
        ],
      ),
    );
  }

  Widget _crearZonaMostarMensajes() {
    return Expanded(
      child: StreamBuilder(
        stream: ServicioChat().getMensajes(
          ServicioAuth().getUsuarioActual()!.uid,
          widget.idReceptor,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error carregant missatges..."));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((document) => _construirItemMensaje(document))
                .toList(),
          );
        },
      ),
    );
  }

  Widget _construirItemMensaje(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    return BurbujaMensaje(
      mensaje: data["mensaje"],
      idAutor: data["idAutor"],
      Fecha: data["timestamp"],
    );
  }

  Widget _crearZonaEscribirMensajes() {
    return Container(
      color: const Color.fromARGB(255, 255, 224, 140), // groc com la imatge
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: Teclado,
              controller: tecMensaje,
              decoration: const InputDecoration(
                hintText: "Escriu el missatge...",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: enviarMensaje,
            icon: const Icon(Icons.send),
            color: Colors.green,
            iconSize: 30,
          ),
        ],
      ),
    );
  }

  void enviarMensaje() {
    if (tecMensaje.text.trim().isNotEmpty) {
      ServicioChat().enviarMensaje(widget.idReceptor, tecMensaje.text.trim());
      tecMensaje.clear();

      Future.delayed(const Duration(milliseconds: 100), () {
        hacerScrollAbajo();
      });
    }
  }
}