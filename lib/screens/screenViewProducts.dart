import 'package:almacen_los_pilas/services/services.dart';
import 'package:flutter/material.dart';

class Screenviewproducts extends StatefulWidget {
  const Screenviewproducts({super.key});

  @override
  State<Screenviewproducts> createState() => _ScreenviewproductsState();
}

class _ScreenviewproductsState extends State<Screenviewproducts> {
  @override
  void setState(VoidCallback fn) async {
    super.setState(fn);
    await getData();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizar Productos'),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int? datos = snapshot.data?.length;
            if (datos != 0) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, idex) {
                  final producto = snapshot.data?[idex];
                  return Column(
                    children: <Widget>[
                      Dismissible(
                        key: Key(producto['uid']),
                        background: Container(
                          color: Colors.red,
                          child: const Icon(Icons.delete),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) async {
                          await deleteProduct(snapshot.data?[idex]['uid']);

                          snapshot.data?.removeAt(idex);
                        },
                        confirmDismiss: (direction) async {
                          try {
                            bool resultado = false;
                            resultado = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Estas seguro de eliminar a ${snapshot.data?[idex]['nombreProducto']}',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          return Navigator.pop(context, false);
                                        },
                                        child: const Text(
                                          'Cancelar',
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                        },
                                        child: const Text(
                                          'Sí, estoy seguro',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                            return resultado;
                          } catch (e) {
                            print('Error en: $e');
                            return null;
                          }
                        },
                        child: ListTile(
                          title: Text(
                            snapshot.data?[idex]['nombreProducto'],
                          ),
                          titleTextStyle: const TextStyle(
                            fontSize: 40,
                            color: Colors.blue,
                          ),
                          subtitle: Text(
                            snapshot.data?[idex]['descripcionProducto'],
                          ),
                          trailing: Text(
                            "Precio: ${snapshot.data?[idex]['precioProducto']}",
                            textAlign: TextAlign.right,
                          ),
                          onTap: () async {
                            try {
                              Navigator.pushNamed(
                                context,
                                'view',
                                arguments: {
                                  'uid': snapshot.data?[idex]['uid'],
                                  'nombreProducto': snapshot.data?[idex]
                                      ['nombreProducto'],
                                  'descripcionProducto': snapshot.data?[idex]
                                      ['descripcionProducto'],
                                  'cantidadInventario': snapshot.data?[idex]
                                      ['cantidadInventario'],
                                  'precioProducto': snapshot.data?[idex]
                                      ['precioProducto'],
                                },
                              );
                              await snapshot.data?.removeAt(idex);
                            } catch (e) {
                              print('Error en $e');
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  'No se existen productos Registrados',
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
