import 'package:flutter/material.dart';
import 'package:hupomnesis/src/resources/storing_manager.dart';
import 'package:hupomnesis/src/views/login_sign_up.dart';
import 'package:hupomnesis/src/views/note_view.dart';
class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: data.initializeUser(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return snapshot.data ? NoteView() : LoginSignUpPage();
            break;
          default: 
            return const CircularProgressIndicator();
            break;
        }
      },
    );
  }
}