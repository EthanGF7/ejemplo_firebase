import 'package:ejemplo_firebase/auth/servicio_auth.dart';
import 'package:ejemplo_firebase/components/boton_auth.dart';
import 'package:ejemplo_firebase/components/textfield_auth.dart';
import 'package:flutter/material.dart';

class PaginaResgistro extends StatelessWidget {
  const PaginaResgistro({super.key});

  void hacerRegistro() {

    final ServicioAuth servicioAuth = ServicioAuth(

    );
    servicioAuth.registroConEmailPassword("email1@gmail.com", "123456");
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController tecEmail = TextEditingController();
    final TextEditingController tecPassword = TextEditingController();
    final TextEditingController tecConfPassw = TextEditingController();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 183, 159),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Logo
                const Icon(Icons.fireplace,
                    size: 120, color: Color.fromARGB(255, 255, 240, 218)),
                const SizedBox(
                  height: 25,
                ),
                //Frase
                const Text(
                  "Crear una cuenta nueva",
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 240, 218),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 25,
                ),

                //Texto divisor
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                              thickness: 1,
                              color: Color.fromARGB(255, 255, 240, 218))),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          "Registrate",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 240, 218)),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                              thickness: 1,
                              color: Color.fromARGB(255, 255, 240, 218))),
                    ],
                  ),
                ),
                //TextField email
                TextfieldAuth(
                  controller: tecEmail,
                  hintText: "Escribe tu email...",
                  obscureText: false,
                ),
                //TextField password
                TextfieldAuth(
                  controller: tecConfPassw,
                  obscureText: true,
                  hintText: "Escoje una contraseña",
                ),

                //TextField confirm password
                TextfieldAuth(
                  controller: tecPassword,
                  obscureText: true,
                  hintText: "Reescribe la contraseña",
                ),

                const SizedBox(
                  height: 10,
                ),
                //Boton no estas registrado?
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Ya tienes una cuenta?",
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        child: const Text(
                          "Haz login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 40, 71, 97)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //Boton registrarse
                BotonAuth(
                  texto: "Registro",
                  onTap: hacerRegistro,
                ),
                BotonAuth(
                  texto: "LogOut",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}