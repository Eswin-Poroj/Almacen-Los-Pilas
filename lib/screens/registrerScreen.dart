// ignore_for_file: use_build_context_synchronously

import 'package:almacen_los_pilas/services/servicesAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registrerscreen extends StatefulWidget {
  const Registrerscreen({super.key});

  @override
  State<Registrerscreen> createState() => _RegistrerScreenState();
}

class _RegistrerScreenState extends State<Registrerscreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  void registrer() async {
    try {
      String username = usernameController.text;
      String password = passwordController.text;
      String confirmPassword = confirmController.text;
      if (password == confirmPassword) {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: username, password: password);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuario Registrado correctamente')));
        Navigator.pushNamed(context, 'home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Las contraseñas no Coinciden')));
      }
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('La contraseña es muy debil')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Este correo ya está registrado')));
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'La dirección de correo electrónico está mal formateada.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('El correo ya está registrado.')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error al registrarse.')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Error al Registrarse')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrer Page'),
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 350,
              child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_2),
                    labelText: 'Ingrese su Correo:',
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
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 350,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  suffix: IconButton(
                    icon: Icon(
                      _obscureText1 ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText1 = !_obscureText1;
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
                obscureText: _obscureText1,
                obscuringCharacter: '*',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 350,
              child: TextField(
                controller: confirmController,
                decoration: InputDecoration(
                  suffix: IconButton(
                    icon: Icon(
                      _obscureText2 ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText2 = !_obscureText2;
                      });
                    },
                  ),
                  prefixIcon: const Icon(Icons.password),
                  labelText: 'Confirme su Contraseña:',
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
                obscureText: _obscureText2,
                obscuringCharacter: '*',
              ),
            ),
            const SizedBox(
              height: 20,
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
                      Navigator.pushNamed(context, 'login');
                    },
                    child: const Text('Ya tienes una Cuenta?'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'login');
                    },
                    child: const Text('Inicia Sesión'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                //backgroundColor: WidgetStatePropertyAll(Colors.grey),
                padding: WidgetStatePropertyAll(
                  EdgeInsets.all(20.0),
                ),
              ),
              onPressed: () {
                registrer();
              },
              child: const Text(
                'Registrarse',
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
                    image: NetworkImage(
                        'https://pbs.twimg.com/profile_images/1311763847775125516/mvBRhlDs_400x400.jpg'),
                    width: 30,
                    height: 30,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'loginPhone');
                  },
                  icon: const Icon(
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

  /*

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
          ],
        ),
      ),
    );
  }
  */
}
