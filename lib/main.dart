import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hupomnesis/src/views/note_page/note_page.dart';

void main() {
  runApp(
    Hupomnesis(),
  );
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
}

///
/// Entry point for flutter app Hupomnesis
/// 
class Hupomnesis extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hupomnesis',
      home: NotePage(),
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
