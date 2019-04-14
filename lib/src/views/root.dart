import 'package:flutter/material.dart';
import 'package:hupomnesis/src/model/user.dart';

class Root extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Container(
        child: Text('${user.id}, ${user.nickname}, ${user.photoUrl}'),
      ),
    );
  }
}