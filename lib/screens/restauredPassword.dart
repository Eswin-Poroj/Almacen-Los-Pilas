import 'package:almacen_los_pilas/services/servicesAuth.dart';
import 'package:flutter/material.dart';

class Restauredpassword extends StatefulWidget {
  const Restauredpassword({super.key});

  @override
  State<Restauredpassword> createState() => _RestauredpasswordState();
}

class _RestauredpasswordState extends State<Restauredpassword> {
  TextEditingController emailControllerr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restablece tu Contraseña'),
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 350,
              child: TextField(
                controller: emailControllerr,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Ingrese su correo:',
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
              height: 34,
            ),
            ElevatedButton(
              onPressed: () {
                try {
                  restauredPassword(emailControllerr.text);
                  Navigator.pushNamed(context, 'login');
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error'),
                    ),
                  );
                }
              },
              child: const Text('Enviar Correo'),
            ),
          ],
        ),
      ),
    );
  }
}
