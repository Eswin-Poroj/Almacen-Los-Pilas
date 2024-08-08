import 'package:almacen_los_pilas/services/servicesAuth.dart';
import 'package:flutter/material.dart';

class Loginphone extends StatefulWidget {
  const Loginphone({super.key});

  @override
  State<Loginphone> createState() => _LoginphoneState();
}

class _LoginphoneState extends State<Loginphone> {
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Phone'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: phoneNumberController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                labelText: 'Ingrese la Cantidad del Producto:',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 34,
            ),
            ElevatedButton(
              onPressed: () {
                loginNumberPhone(phoneNumberController.text);
                Navigator.pushNamed(context, 'login');
              },
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
