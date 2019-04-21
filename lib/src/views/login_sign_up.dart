import 'package:flutter/material.dart';
import 'package:hupomnesis/src/model/user.dart';
import 'package:hupomnesis/src/resources/storing_manager.dart';

class LoginSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<bool>(
      future: data.initializeUser(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        switch (snapshot.data) {
          case false:
            return Scaffold(
              body: Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.7,),
                  TextField(
                    
                  ),
                ],
              ),
            );
            break;
          case true:
            Navigator.pushNamed(context, '/home');
            break;
        }
      },
    );
  }
}


