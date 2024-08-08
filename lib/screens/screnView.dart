import 'package:flutter/material.dart';

class Screnview extends StatelessWidget {
  const Screnview({super.key});

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Producto: ${arguments['nombreProducto']}",
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'edit', arguments: {
                'uid': arguments['uid'],
                'nombreProducto': arguments['nombreProducto'],
                'descripcionProducto': arguments['descripcionProducto'],
                'cantidadInventario': arguments['cantidadInventario'],
                'precioProducto': arguments['precioProducto'],
              });
            },
            child: const Icon(Icons.edit),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 14,
            ),
            Text(
              arguments['nombreProducto'],
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            const Text(
              'Descripcion: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Text(
              arguments['descripcionProducto'],
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 14,
            ),
            const Text(
              'Cantidad En Stock: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Text(
              "${arguments['cantidadInventario']} unidades",
            ),
            const SizedBox(
              height: 14,
            ),
            const Text(
              'Precio por Unidad: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Text(
              "Q ${arguments['precioProducto']}",
            ),
          ],
        ),
      ),
    );
  }
}
