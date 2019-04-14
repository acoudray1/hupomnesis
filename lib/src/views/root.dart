import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Root extends StatelessWidget {
  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Container(
        child: Text('${prefs.getString('id')}, ${prefs.getString('nickname')}, ${prefs.getString('photoUrl')}'),
      ),
    );
  }
}