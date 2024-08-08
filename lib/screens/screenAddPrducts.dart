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
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(
          left: 30.0,
          right: 30.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 400.0,
              child: TextField(
                controller: nombreProductoController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: 'Ingrese el Nombre del Producto:',
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
            SizedBox(
              width: 400.0,
              child: TextField(
                controller: descripcionProductoController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: 'Ingrese la Descripción del Producto:',
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
            SizedBox(
              width: 400.0,
              child: TextField(
                controller: cantidadProductoController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
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
            ),
            const SizedBox(
              height: 34,
            ),
            SizedBox(
              width: 400.0,
              child: TextField(
                controller: precioProductoController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: 'Ingrese el Precio del Producto:',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))
                ],
              ),
            ),
            const SizedBox(
              height: 34,
            ),
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
                addProducto();
              },
              child: const Text(
                'Agregar Producto',
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
