import 'package:flutter/material.dart';
import 'package:hupomnesis/src/model/user.dart';
import 'package:hupomnesis/src/resources/storing_manager.dart';

class LoginSignUpPage extends StatefulWidget {
  @override
  _LoginSignUpPageState createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {

  @override
  void initState() {
    super.initState();
    data.initializeUser();
  }

  @override
  Widget build(BuildContext context) {

    user.name == 'default' ? 
    Scaffold(

    ) : Navigator.pushNamed(context, 'home');
  }
}