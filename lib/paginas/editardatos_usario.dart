import 'dart:io';
import 'dart:typed_data';
import 'package:ejemplo_firebase/autenticaion/servicio_auth.dart';
import 'package:ejemplo_firebase/mongodb/db_conf.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongodb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditardatosUsario extends StatefulWidget {
  const EditardatosUsario({super.key});

  @override
  State<EditardatosUsario> createState() => _EditardatosUsarioState();
}

class _EditardatosUsarioState extends State<EditardatosUsario> {
  mongodb.Db? _db;
  Uint8List? _imatgeEnBytes;
  final ImagePicker imagePicker = ImagePicker();

  final TextEditingController _tecNombre = TextEditingController();
  String? _emailUsuario;

  @override
  void dispose() {
    _db?.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _connectarConMongoDB();
    _cargarDatosUsuario();
  }

  Future<void> _connectarConMongoDB() async {
    try {
      _db = await mongodb.Db.create(DBCOnf().connectionString);
      await _db!.open();
      print("Conectado con MongoDB");
    } catch (e) {
      print("Error conectando con MongoDB: $e");
    }
  }

  Future<void> _cargarDatosUsuario() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _emailUsuario = user.email;

      final doc = await FirebaseFirestore.instance
          .collection("usuarios")
          .doc(user.uid)
          .get();

      if (doc.exists && doc.data()!.containsKey("nom")) {
        _tecNombre.text = doc["nom"];
      }

      setState(() {});
    }
  }

  Future<void> _guardarNombre() async {
    final texto = _tecNombre.text.trim();
    if (texto.isEmpty) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection("usuarios")
          .doc(user.uid)
          .update({"nom": texto});

      if (context.mounted) {
        Navigator.pop(context); // Tornar enrere després de guardar
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Datos Usuario"),
        backgroundColor: Colors.blueGrey[200],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Edita tus datos",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _imatgeEnBytes != null
                ? Image.memory(_imatgeEnBytes!, height: 200)
                : const Text("No se ha seleccionado ninguna imagen"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _SubirImagenes,
              child: const Text("Subir Imagen"),
            ),
            ElevatedButton(
              onPressed: _recuperarImagen,
              child: const Text("Recuperar Imagen"),
            ),

            const SizedBox(height: 40),
            // 🔽 Sección para editar nombre
            if (_emailUsuario != null)
              Text(
                _emailUsuario!,
                style: const TextStyle(fontSize: 16),
              ),

            const SizedBox(height: 20),

            TextField(
              controller: _tecNombre,
              decoration: const InputDecoration(
                hintText: "Escriu el teu nom...",
                border: UnderlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: _guardarNombre,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 202, 174, 238),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text("Guardar", style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _SubirImagenes() async {
    try {
      final imgSeleccionada =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (imgSeleccionada != null) {
        final imgBytes = await File(imgSeleccionada.path).readAsBytes();
        final datosBinaries = mongodb.BsonBinary(imgBytes as int);

        if (_db == null) {
          print("Error: No hay conexión con la base de datos");
          return;
        }

        final collection = _db!.collection("imagenes_perfiles");
        final usuario = ServicioAuth().getUsuarioActual();

        if (usuario == null) {
          print("Error: Usuario no autenticado");
          return;
        }

        await collection.replaceOne(
          {"id_usuario_firebase": usuario.uid},
          {
            "id_usuario_firebase": usuario.uid,
            "nombre_foto": "foto_perfil",
            "imagen": datosBinaries,
            "fecha_subida": DateTime.now()
          },
          upsert: true,
        );
        print("Imagen Subida");
      }
    } catch (e) {
      print("Error al subir imagen: $e");
    }
  }

  Future<void> _recuperarImagen() async {
    try {
      if (_db == null) {
        print("Error: No hay conexión con la base de datos");
        return;
      }

      final collection = _db!.collection("imagenes_perfiles");
      final usuario = ServicioAuth().getUsuarioActual();

      if (usuario == null) {
        print("Error: Usuario no autenticado");
        return;
      }

      final doc =
          await collection.findOne({"id_usuario_firebase": usuario.uid});

      if (doc != null && doc["imagen"] != null) {
        final imgBson = doc["imagen"] as mongodb.BsonBinary;
        setState(() {
          _imatgeEnBytes = imgBson.byteList;
        });
      } else {
        print("No se encontró imagen para este usuario");
      }
    } catch (e) {
      print("Error intentando recuperar la imagen: $e");
    }
  }
}