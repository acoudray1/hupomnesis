import 'package:flutter/material.dart';
import 'package:hupomnesis/src/model/user.dart';
import 'package:hupomnesis/src/resources/storing_manager.dart';
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
            return snapshot.data ? home(context) : Navigator.pushNamed(context, '/login_page');
            break;
          default: 
            return const CircularProgressIndicator();
            break;
        }
      },
    );
  }

  Widget home(BuildContext context) {
     return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.3,),
          Center(child: Text('Welcome ${user.name}')),
          SizedBox(height: MediaQuery.of(context).size.height * 0.3,),
          Center(child: RaisedButton(
            child: const Text('DELETE USER'),
            onPressed: () {
              data.deleteUser();
              Navigator.pushNamed(context, '/login_page');
            },
          ),)
        ],
      )
    );
  }
}