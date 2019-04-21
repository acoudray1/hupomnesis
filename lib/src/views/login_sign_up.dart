import 'package:flutter/material.dart';
import 'package:hupomnesis/src/model/user.dart';
import 'package:hupomnesis/src/resources/storing_manager.dart';

class LoginSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<bool>(
      future: data.initializeUser(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return snapshot.data ? Navigator.pushNamed(context, '/home') : loginScreen(context);
            break;
          default: 
            return const CircularProgressIndicator();
            break;
        }
      },
    );
  }

  Widget loginScreen(BuildContext context) {
    print(user.name);
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.7,),
          Container()
        ],
      ),
    );
  }
}


