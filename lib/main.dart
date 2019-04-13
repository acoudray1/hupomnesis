import 'package:flutter/material.dart';
import 'package:hupomnesis/src/views/root.dart';

void main(List<String> args) {
  runApp(
    Hupomnesis(),
  );
}


class Hupomnesis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hupomnesis',
      home: Root(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.blue),
        accentColor: Colors.blueAccent,
        brightness: Brightness.light,
      ),
    );
  }
}
