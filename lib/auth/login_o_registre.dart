import 'package:ejemplo_firebase/paginas/pagina_login.dart';
import 'package:ejemplo_firebase/paginas/pagina_registro.dart';
import 'package:flutter/material.dart';

class LoginORegistre extends StatefulWidget {
  const LoginORegistre({super.key});

  @override
  State<LoginORegistre> createState() => _LoginORegistreState();
}

class _LoginORegistreState extends State<LoginORegistre> {

  bool mostrarPaginaLogin = true;

  void intercanviarPaginaLoginRegistre() {
    setState(() {
      mostrarPaginaLogin = !mostrarPaginaLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mostrarPaginaLogin == true) {
      return PaginaLogin(ferClic: intercanviarPaginaLoginRegistre,);
    } else {
      return PaginaRegistro(ferClic: intercanviarPaginaLoginRegistre,);
    }
    
  }
}