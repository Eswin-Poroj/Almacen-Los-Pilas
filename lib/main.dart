import 'package:almacen_los_pilas/firebase_options.dart';
import 'package:almacen_los_pilas/screens/screenEdit.dart';
import 'package:almacen_los_pilas/screens/screenHome.dart';
import 'package:almacen_los_pilas/screens/screnView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: 'home',
      routes: {
        'home': (context) => const ScreenHome(),
        'view': (context) => const Screnview(),
        'edit': (context) => const ScreenEdit(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
