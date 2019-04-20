import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hupomnesis/src/views/root.dart';

void main() {
  runApp(
    Hupomnesis(),
  );
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setEnabledSystemUIOverlays(<SystemUiOverlay>[]);
}

///
/// Entry point for flutter app Hupomnesis
/// 
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
