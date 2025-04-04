import 'dart:io';
import 'dart:typed_data';
import 'package:ejemplo_firebase/autenticaion/servicio_auth.dart';
import 'package:ejemplo_firebase/mongodb/db_conf.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongodb;

class EditardatosUsario extends StatefulWidget {
  const EditardatosUsario({super.key});

  @override
  State<EditardatosUsario> createState() => _EditardatosUsarioState();
}

class _EditardatosUsarioState extends State<EditardatosUsario> {
  mongodb.Db? _db;
  Uint8List? _imatgeEnBytes;
  final ImagePicker imagePicker = ImagePicker();

  @override
  void dispose() {
    _db?.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _connectarConMongoDB();
  }

  Future<void> _connectarConMongoDB() async {
    try {
      _db = await mongodb.Db.create(DBCOnf().connectionString);
      await _db!.open();
      print("Conectado con MongoDB");
    } catch (e) {
      print("Error conectando con MongoDB: \$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Datos Usuario"),
        backgroundColor: Colors.blueGrey[200],
      ),
      body: Center(
        child: Column(
          children: [
            Text("Edita tus datos"),
            _imatgeEnBytes != null
                ? Image.memory(_imatgeEnBytes!, height: 200)
                : Text("No se ha seleccionado ninguna imagen"),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: _SubirImagenes, child: Text("Subir Imagen")),
            ElevatedButton(
                onPressed: _recuperarImagen, child: Text("Recuperar Imagen")),
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
      print("Error al subir imagen: \$e");
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
      print("Error intentando recuperar la imagen: \$e");
    }
  }
}