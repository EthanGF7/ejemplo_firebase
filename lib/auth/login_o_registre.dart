
import 'package:ejemplo_firebase/paginas/pagLogin.dart';
import 'package:ejemplo_firebase/paginas/pagRegristro.dart';
import 'package:flutter/material.dart';

class LoginORegistre extends StatefulWidget {
  const LoginORegistre({super.key});

  @override
  State<LoginORegistre> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoginORegistre> {

  bool mostraPagLogin = true;

  void intercanviarPaginaLoginRegistre(){
    setState(() {
      mostraPagLogin = !mostraPagLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mostraPagLogin) {
      return Paglogin(ferClick: intercanviarPaginaLoginRegistre,);
    }else{
      return paginaregristro(ferClick: intercanviarPaginaLoginRegistre,);
    }
  }
}