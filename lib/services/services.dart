import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

//Leer datos de la Base de DAtos en FireBase
Future<List> getData() async {
  List producto = [];

  CollectionReference collectionReference = db.collection('products');

  QuerySnapshot querySnapshot = await collectionReference.get();

  for (var doc in querySnapshot.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final prodct = {
      'uid': doc.id,
      'nombreProducto': data['nombreProducto'],
      'cantidadInventario': data['cantidadInventario'],
      'descripcionProducto': data['descripcionProducto'],
      'precioProducto': data['precioProducto'],
    };

    producto.add(prodct);
  }

  Future.delayed(
    const Duration(seconds: 5),
  );

  return producto;
}

Future<void> insertProduct(Map<String, dynamic> datos) async {
  db.collection('products').add(datos);
}

//Eliminar Producto
Future<void> updateProduct(Map<String, dynamic> datos) async {
  db.collection('products').doc(datos['uid']).update(datos);
}

Future<void> deleteProduct(String id) async {
  db.collection('products').doc(id).delete();
}
