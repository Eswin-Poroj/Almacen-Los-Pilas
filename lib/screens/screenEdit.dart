import 'package:flutter/material.dart';

class ScreenEdit extends StatefulWidget {
  const ScreenEdit({super.key});

  @override
  State<ScreenEdit> createState() => _ScreenEditState();
}

class _ScreenEditState extends State<ScreenEdit> {
  @override
  Widget build(BuildContext context) {
    final Map argumens = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
