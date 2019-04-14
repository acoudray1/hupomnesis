import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hupomnesis/src/model/user.dart';
import 'package:hupomnesis/src/views/login_sign_up_page.dart';
import 'package:hupomnesis/src/views/root.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseManager {

  FirebaseManager({this.name, this.options});

  String name; @required
  FirebaseOptions options; @required

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences prefs;
  FirebaseUser currentUser;

  ///
  /// Firebase configuration
  /// 
  Future<void> configure() async {
    final FirebaseApp app = await FirebaseApp.configure(
      name: name,
      options: options,
    );
    assert(app != null);
    print('Configured $app');
  }

  ///
  /// Check if the user is already signed in or not
  /// 
  Future<bool> isSignedIn() async {
    prefs = await SharedPreferences.getInstance();

    final bool ret = await googleSignIn.isSignedIn();

    // Update the user singleton for the session
    user.id = prefs.getString('id');
    user.nickname = prefs.getString('nickname');
    user.photoUrl = prefs.getString('photoUrl');

    return ret;
  }

  ///
  /// Handle the authentification part
  /// 
  Future<Root> handleSignIn() async {
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
      
      // Update the user singleton for the session
      user.id = prefs.getString('id');
      user.nickname = prefs.getString('nickname');
      user.photoUrl = prefs.getString('photoUrl');
    }
    return Root();
  }

  ///
  /// Handle the sign out part
  /// 
  Future<LoginSignUpPage> handleSignOut() async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
    
    return LoginSignUpPage();
  }
}