import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hupomnesis/theme/text_style.dart';

class LoginSignUpPage extends StatefulWidget {
  @override
  _LoginSignUpPageState createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences prefs;

  bool isLoading = false;
  bool isLoggedIn = false;
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  ///
  /// Check if the user is already signed in or not
  /// 
  Future<void> isSignedIn() async {
    setState(() {
      isLoading = true;
    });

    isLoggedIn = await googleSignIn.isSignedIn();
    if(isLoggedIn) {
      Navigator.pop(context);
      isLoading = false;
    }
  }

  ///
  /// Handle the authentification part
  /// 
  Future<void> handleSignIn() async {
    prefs = await SharedPreferences.getInstance();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser firebaseUser = await firebaseAuth.signInWithCredential(credential);

    if(firebaseUser != null) {
      // Check if already signed up
      final QuerySnapshot result = 
        await Firestore.instance.collection('users').where('id', isEqualTo: firebaseUser.uid).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.isEmpty) {
        // Update data to server if new user
        Firestore.instance
          .collection('users')
          .document(firebaseUser.uid)
          .setData(<String, dynamic>{
            'nickname': firebaseUser.displayName, 
            'photoUrl': firebaseUser.photoUrl, 
            'id': firebaseUser.uid});
        // write data to local
        currentUser = firebaseUser;
        await prefs.setString('id', currentUser.uid);
        await prefs.setString('nickname', currentUser.displayName);
        await prefs.setString('photoUrl', currentUser.photoUrl);
      } else {
        // Write data to local
        await prefs.setString('id', documents[0]['id']);
        await prefs.setString('nickname', documents[0]['nickname']);
        await prefs.setString('photoUrl', documents[0]['photoUrl']);
        await prefs.setString('aboutMe', documents[0]['aboutMe']);
      }
      Fluttertoast.showToast(msg: 'Sign in success');
    }
  }

  ///
  /// User Interface Implementation for login screen
  ///
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height*0.75),
        Center(
          child: FlatButton(
            onPressed: handleSignIn,
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
    );
  }
}