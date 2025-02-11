import 'package:ejemplo_firebase/components/boton_auth.dart';
import 'package:ejemplo_firebase/components/textfield_auth.dart';
import 'package:flutter/material.dart';

class PaginaRegistrro extends StatelessWidget {

  const PaginaRegistrro({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController tecEmail = TextEditingController();
    final TextEditingController tecPassword = TextEditingController();
    final TextEditingController tecConfPass = TextEditingController();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 183, 159),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                //Logo
                  const Icon(
                  Icons.fireplace,
                  size: 120,
                  color: Color.fromARGB(255, 255, 240, 218),
                  ),
                  const SizedBox(height: 25,),
            
                //frase
                const Text(
                    "Crear una cuenta nueva",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 240, 218),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
            
                  const SizedBox(height: 25,),
            
                //textfield divisori
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(child: Divider(
                        thickness: 1,
                        color: Color.fromARGB(255, 255, 240, 218),
                      ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          "Registrate",
                          style: TextStyle(color: Color.fromARGB(255, 255, 240, 218)),
                        ),
                      ),
                      Expanded(child: Divider(
                        thickness: 1,
                        color: Color.fromARGB(255, 255, 240, 218),
                      ),
                      ),
                    ],
                  ),
                ),
            
                //textfield email
                TextfieldAuth(
                  controller: tecEmail,
                  obscureText: false,
                  hintText: "Escribe tu email",
                  ),
            
                // textfield password
                TextfieldAuth(
                  controller: tecPassword,
                  obscureText: false,
                  hintText: "Escoge tu contraseña",
                ),
            
                //textfield confirm password
               TextfieldAuth(
                controller: tecConfPass,
                obscureText: false,
                hintText: "Reescribe la contraseña",
               ),
            
               const SizedBox(height: 10,),
            
                //boton no estas registrado?
                 Padding(
                  padding: EdgeInsets.only(right:25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("¿Ya eres miembro?"),
                      SizedBox(width: 5,),
                      GestureDetector(
                        child: Text("Haz login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 40, 71, 97),
                        ),
                        ),
                      ),
                        
                    ],
                  ),
                ),

            
                //boton registro
                BotonAuth(),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}