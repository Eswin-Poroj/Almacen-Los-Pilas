import 'package:almacen_los_pilas/screens/screenAddPrducts.dart';
import 'package:almacen_los_pilas/screens/screenViewProducts.dart';
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
        title: const Text('Almacen Los Pilas'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Agregar Producto'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Screenaddprducts(),
                  ),
                );
              },
              child: const Text('Agregar Producto'),
            ),
            const SizedBox(height: 24),
            const Text('Ver Productos'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Screenviewproducts(),
                  ),
                );
              },
              child: const Text('Ver Productos'),
            ),
          ],
        ),
      ),
    );
  }
}
