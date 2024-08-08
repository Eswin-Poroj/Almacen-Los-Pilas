// ignore_for_file: use_build_context_synchronously

import 'package:almacen_los_pilas/screens/screenAddPrducts.dart';
import 'package:almacen_los_pilas/screens/screenViewProducts.dart';
import 'package:almacen_los_pilas/services/servicesAuth.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Almacen Los Pilas'),
        actions: [
          IconButton(
            onPressed: () async {
              Future.delayed(const Duration(seconds: 3));
              await logoutSession();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  'login', (Route<dynamic> route) => false);
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.grey),
                padding: WidgetStatePropertyAll(
                  EdgeInsets.only(
                    right: 35,
                    left: 35,
                    top: 20,
                    bottom: 20,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Screenaddprducts(),
                  ),
                );
              },
              child: const Text(
                'Agregar Producto',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Colors.grey,
                ),
                padding: WidgetStatePropertyAll(
                  EdgeInsets.only(
                    top: 20,
                    right: 45,
                    left: 45,
                    bottom: 20,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Screenviewproducts(),
                  ),
                );
              },
              child: const Text(
                'Ver Productos',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
