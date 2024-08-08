// ignore_for_file: use_build_context_synchronously

import 'package:almacen_los_pilas/services/services.dart';
import 'package:flutter/material.dart';

class ScreenEdit extends StatefulWidget {
  const ScreenEdit({super.key});

  @override
  State<ScreenEdit> createState() => _ScreenEditState();
}

class _ScreenEditState extends State<ScreenEdit> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController cantidadController = TextEditingController();
  TextEditingController precioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map argumens = ModalRoute.of(context)!.settings.arguments as Map;
    nombreController.text = argumens['nombreProducto'];
    descripcionController.text = argumens['descripcionProducto'];
    cantidadController.text = argumens['cantidadInventario'];
    precioController.text = argumens['precioProducto'];
    String uid = argumens['uid'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar datos Producto'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          left: 30.0,
          right: 30.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'MODIFIQUE EL NOMBRE:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 400.0,
              child: TextField(
                controller: nombreController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
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
              height: 20,
            ),
            const Text(
              'DESCRIPCIÓN:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 400.0,
              child: TextField(
                controller: descripcionController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
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
              height: 20,
            ),
            const Text(
              'CANTIDAD:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 400.0,
              child: TextField(
                controller: cantidadController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
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
              height: 20,
            ),
            const Text(
              'PRECIO:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 400.0,
              child: TextField(
                controller: precioController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
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
              onPressed: () async {
                try {
                  String nombreProducto = nombreController.text;
                  String descripcionProduco = descripcionController.text;
                  String cantidadInventario = cantidadController.text;
                  String precioProducto = precioController.text;

                  final producto = <String, dynamic>{
                    'uid': uid,
                    'nombreProducto': nombreProducto,
                    'cantidadInventario': cantidadInventario,
                    'descripcionProducto': descripcionProduco,
                    'precioProducto': precioProducto,
                  };

                  await updateProduct(producto).then((_) {
                    Future.delayed(const Duration(seconds: 5));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Exito, Producto Actualizado')));
                    Navigator.pushNamed(context, 'viewProducts');
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fallo la actualización')));
                }
              },
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
              child: const Text(
                'Guardar Cambios',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
