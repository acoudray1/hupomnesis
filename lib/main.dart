import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hupomnesis/src/views/login_sign_up_page.dart';
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

  final String name = 'Hupomnesis';
  final FirebaseOptions options = const FirebaseOptions(
    googleAppID: '1:475271504195:android:ce83a0859030f209',
    gcmSenderID: 'reminder-ed319',
    apiKey: 'AIzaSyB9NLG_CCNKPuKj4NVxq4vskllQfzDLJfU',
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hupomnesis',
      home: LoginSignUpPage(fName: name, fOptions: options),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.blue),
        accentColor: Colors.blueAccent,
        brightness: Brightness.light,
      ),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => Root(),
        '/login': (BuildContext context) => LoginSignUpPage(fName: name, fOptions: options),
      },
    );
  }
}
