import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hupomnesis/src/resources/firebase_manager.dart';
import 'package:hupomnesis/theme/text_style.dart';

class LoginSignUpPage extends StatefulWidget {

  LoginSignUpPage({this.fName, this.fOptions});

  String fName; @required
  FirebaseOptions fOptions; @required

  @override
  _LoginSignUpPageState createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  FirebaseManager firebaseManager = FirebaseManager();
  bool isSignedIn = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    firebaseManager.configure();
  }

  Future<void> start() async {
    isSignedIn = await firebaseManager.isSignedIn();
    setState(() {
      if(isSignedIn)
        Navigator.pushNamed(context, '/home');
    });
  }

  ///
  /// User Interface Implementation for login screen
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height*0.6),
          Center(
            child: FlatButton(
              onPressed: firebaseManager.handleSignOut,
              child: Text('SIGN OUT OF THE APP', style: Style.subtitleTextStyle),
              color: const Color(0xffdd4b39),
                highlightColor: const Color(0xffff7f7f),
                splashColor: Colors.transparent,
                textColor: Colors.white,
                padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0)
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.2),
          Center(
            child: FlatButton(
              onPressed: firebaseManager.handleSignIn,
              child: Text('SIGN IN WITH GOOGLE', style: Style.subtitleTextStyle),
              color: const Color(0xffdd4b39),
                highlightColor: const Color(0xffff7f7f),
                splashColor: Colors.transparent,
                textColor: Colors.white,
                padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0)
            ),
          ),
          const SizedBox(height: 35.0,),
          isLoading ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan)) 
                    : Container(),
        ],
      ),
    );
  }
}