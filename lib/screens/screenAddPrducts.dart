import 'package:almacen_los_pilas/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Screenaddprducts extends StatefulWidget {
  const Screenaddprducts({super.key});

  @override
  State<Screenaddprducts> createState() => _ScreenaddprductsState();
}

class _ScreenaddprductsState extends State<Screenaddprducts> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nombreProductoController = TextEditingController();
  TextEditingController descripcionProductoController = TextEditingController();
  TextEditingController cantidadProductoController = TextEditingController();
  TextEditingController precioProductoController = TextEditingController();

  void addProducto() async {
    try {
      String nombreProducto = nombreProductoController.text;
      String descripcionProduco = descripcionProductoController.text;
      String cantidadInventario = cantidadProductoController.text;
      String precioProducto = precioProductoController.text;

      final producto = <String, dynamic>{
        'nombreProducto': nombreProducto,
        'cantidadInventario': cantidadInventario,
        'descripcionProducto': descripcionProduco,
        'precioProducto': precioProducto,
      };

      await insertProduct(producto).then((_) {
        Future.delayed(
          const Duration(seconds: 5),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Producto Agregado'),
          ),
        );
        Navigator.pop(context);
      });
    } catch (e) {
      print('Fallo en $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nombreProductoController,
              decoration: const InputDecoration(
                labelText: 'Ingrese Nombre de Producto',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: descripcionProductoController,
              decoration: const InputDecoration(
                labelText: 'Ingrese la Descripcion de Producto',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: cantidadProductoController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                labelText: 'Ingrese la Cantidad del Producto',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: precioProductoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ingrese el Precio del Producto',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                addProducto();
              },
              child: const Text('Agregar Producto'),
            ),
          ],
        ),
      ),
    );
  }
}
