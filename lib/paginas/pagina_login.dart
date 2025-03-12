import 'package:ejemplo_firebase/auth/servei_auth.dart';
import 'package:ejemplo_firebase/componetes/boto_auth.dart';
import 'package:ejemplo_firebase/componetes/textfield_auth.dart';
import 'package:flutter/material.dart';

class PaginaLogin extends StatelessWidget {
final Function() ferClic;
  
  const PaginaLogin({super.key, required this.ferClic});

  Future<void> ferLogin(BuildContext context, String email, String password) async {
    String? error = await ServeriAuth().loginEmailPassword(email, password);

    if (error != null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: const Color.fromARGB(255, 163, 169, 247),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: const Text("Error"),
                content: Text(email),
              ));
    } else {
      print("Login get.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController tecEmail = TextEditingController();
    final TextEditingController tecPassword = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.indigo[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //logo.
                  const Icon(Icons.fireplace, size: 120, color: Colors.indigo),

                  const SizedBox(height: 25),

                  //Frase.
                  const Text("Iniciar sessión",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),

                  const SizedBox(height: 25),

                  //Text divisoro.
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 150),
                    child: Row(
                      children: [
                        Expanded(
                            child: Divider(thickness: 1, color: Colors.white)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("Login",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                        Expanded(
                            child: Divider(thickness: 1, color: Colors.white)),
                      ],
                    ),
                  ),

                  //textField Email.
                  TextfieldAuth(
                    controller: tecEmail,
                    obscureText: false,
                    hintText: "Email",
                  ),
                  TextfieldAuth(
                    controller: tecPassword,
                    obscureText: true,
                    hintText: "Password",
                  ),

                  const SizedBox(height: 10),

                  //no esta registardo?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("¿Aún no eres miembro?",
                          style: TextStyle(color: Colors.white)),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: ferClic,
                        child: const Text(
                          "Registrate",
                          style: TextStyle(
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  //boton de registro.
                  BotoAuth(
                    text: "Login",
                    onTap: () =>
                        ferLogin(context, tecEmail.text, tecPassword.text),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
