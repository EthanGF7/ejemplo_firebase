
import 'package:ejemplo_firebase/auth/servei_auth.dart';
import 'package:ejemplo_firebase/componentes/Btn_auten.dart';
import 'package:ejemplo_firebase/componentes/TxtFld_auten.dart';
import 'package:flutter/material.dart';

class Paglogin extends StatelessWidget {

  final Function()? ferClick;

  const Paglogin({super.key, this.ferClick});

    void ferLogin(BuildContext context, String email, String password) async{
      String? error = await ServeiAuth().loginAmbEmailIPassword(email, password);

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
      } else {
        print("login fet.");
      }
    }


  @override
  Widget build(BuildContext context) {

    final TextEditingController tecEmail = TextEditingController();
    final TextEditingController tecPasw = TextEditingController();

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
                  "Benvingut/da de nou",
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
                          "Fes login",
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

                //no eta regristrado
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Encara no ets membre?"),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: ferClick,
                        child: const Text("Registre't",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20,),

                //Boton regristro
                BtnAuten(text: "Login", onTap: () => ferLogin(context,tecEmail.text, tecPasw.text),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}