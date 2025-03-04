import 'package:ejemplo_firebase/auth/servei_auth.dart';
import 'package:ejemplo_firebase/componentes/Btn_auten.dart';
import 'package:ejemplo_firebase/componentes/TxtFld_auten.dart';
import 'package:flutter/material.dart';

class paginaregristro extends StatelessWidget {

  final Function()? ferClick;
  const paginaregristro({super.key, this.ferClick});

  void ferRegistre(BuildContext context, String email, String password, String confPassword) async{
    
    if (password.isEmpty || email.isEmpty) {
      //Gestionar-ho
      return;
    }
    if (password != confPassword){
      //Gestio del cas
      return;
    }
    String? error = await ServeiAuth().registreAmbEmailIPassword(email, password);
    
    if (error != null) {
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          backgroundColor: const Color.fromARGB(255, 250, 183, 159),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text("Error"),
          content: Text(error),
        )
      );
    }

    try {
      
    } catch (e) {
      
    }
      

  }
    //final ServeiAuth serveiAuth = ServeiAuth();
    //serveiAuth.registreAmbEmailIPassword("email1@email1.com", "123456");
  

  @override
  Widget build(BuildContext context) {
    final TextEditingController tecEmail = TextEditingController();
    final TextEditingController tecPasw = TextEditingController();
    final TextEditingController tecPasw2 = TextEditingController();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 124, 185, 241),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                const Icon(
                  Icons.fireplace,
                  size: 120,
                  color: Color.fromARGB(255, 245, 123, 66),
                ),

                const SizedBox(
                  height: 25,
                ),

                //frase
                const Text(
                  "crea una cuenta nueva",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                //text divisor
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Color.fromARGB(255, 99, 45, 247),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          "Regristro",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Color.fromARGB(255, 99, 45, 247),
                        ),
                      ),
                    ],
                  ),
                ),

                //mail
                TxtFld_auten(
                    controller: tecEmail,
                    hintTxt: "Escribe tu Email",
                    obscureTxt: false),
                //pasword
                TxtFld_auten(
                    controller: tecPasw,
                    hintTxt: "Escribe la contraseña",
                    obscureTxt: true),
                //confirma pasword
                TxtFld_auten(
                    controller: tecPasw2,
                    hintTxt: "Vuelve a escribir la contraseña",
                    obscureTxt: true),

                //no eta regristrado
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Ya eres miembro"),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: ferClick,
                        child: const Text("Fes Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 7, 17, 107),
                        ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20,),

                //Boton regristro
                BtnAuten(text: "Registra't", onTap: () => ferRegistre(context,tecEmail.text, tecPasw.text, tecPasw2.text),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
