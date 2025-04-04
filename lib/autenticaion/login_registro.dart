
import 'package:ejemplo_firebase/paginas/pagLogin.dart';
import 'package:ejemplo_firebase/paginas/pagRegristro.dart';
import 'package:flutter/material.dart';

class LoginRegistro extends StatefulWidget {


  const LoginRegistro({super.key});

  @override
  State<LoginRegistro> createState() => _LoginRegistroState();
}

class _LoginRegistroState extends State<LoginRegistro> {
  bool mostrarPagLogin = true;

  void intercanvioPagLoginRegistro() {
    setState(() {
    mostrarPagLogin = !mostrarPagLogin;  
    });
    
  }

  @override
  Widget build(BuildContext context) {
    if (mostrarPagLogin) {
      return paginalogin(hacerClick: intercanvioPagLoginRegistro,);
    } else {
      return paginaregristro(hacerClick: intercanvioPagLoginRegistro,);
    }
  }
}
