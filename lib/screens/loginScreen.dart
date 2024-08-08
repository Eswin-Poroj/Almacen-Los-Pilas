// ignore_for_file: use_build_context_synchronously

import 'package:almacen_los_pilas/services/servicesAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController usuarioController = TextEditingController();
  TextEditingController passworController = TextEditingController();
  bool _obscureText = true;

  void login(String username, String password) async {
    try {
      loginEmail(username, password);
      Navigator.pushNamed(context, 'home');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Escriba un correo correcto'),
            ),
          );
          break;
        case 'invalid-credential':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Datos Incorrectos'),
            ),
          );
          break;
        case 'user-disabled':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('La cuenta ha sido desabilitada'),
            ),
          );
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error al iniciar Sesión'),
            ),
          );
          break;
      }
    } catch (e) {
      throw Exception('Error al iniciar Sesión');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 350,
              child: TextField(
                controller: usuarioController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_2),
                  labelText: 'Ingrese su Usuario:',
                  helperStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            SizedBox(
              width: 350,
              child: TextField(
                controller: passworController,
                decoration: InputDecoration(
                  suffix: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  prefixIcon: const Icon(Icons.password),
                  labelText: 'Ingrese su Contraseña:',
                  helperStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                obscureText: _obscureText,
                obscuringCharacter: '*',
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'resturedPassword');
                    },
                    child: const Text('Olvide mi contraseña'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'registrer');
                    },
                    child: const Text('Registrate'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Colors.grey,
                ),
                padding: WidgetStatePropertyAll(
                  EdgeInsets.all(20.0),
                ),
              ),
              onPressed: () {
                login(usuarioController.text, passworController.text);
              },
              child: const Text(
                'Iniciar Sesión',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    try {
                      UserCredential userCredential =
                          await signInWithGoogleWeb();
                      if (userCredential.user != null) {
                        Navigator.pushNamed(context, 'home');
                      }
                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.code),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error al Registrarse'),
                        ),
                      );
                    }
                  },
                  icon: const Image(
                    image: AssetImage('asset/images/google.png'),
                    width: 30,
                    height: 30,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'loginPhone');
                  },
                  child: const Icon(
                    Icons.phone,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  onPressed: () async {
                    try {
                      UserCredential credentialFacebook =
                          await signInWithFacebook();
                      if (credentialFacebook.user != null) {
                        Navigator.pushNamed(context, 'home');
                      }
                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.code),
                        ),
                      );
                    }
                  },
                  icon: const Image(
                    image: NetworkImage(
                        'https://z-m-static.xx.fbcdn.net/rsrc.php/v3/yD/r/5D8s-GsHJlJ.png'),
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
