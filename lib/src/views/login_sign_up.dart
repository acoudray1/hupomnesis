import 'package:flutter/material.dart';
import 'package:hupomnesis/src/resources/storing_manager.dart';
import 'package:hupomnesis/src/views/root.dart';
import 'package:hupomnesis/theme/text_style.dart';

class LoginSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<bool>(
      future: data.initializeUser(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return snapshot.data ? Root() : loginScreen(context);
            break;
          default: 
            return const CircularProgressIndicator();
            break;
        }
      },
    );
  }

  Widget loginScreen(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        // TODO: Background color or image, we'll see
        /*decoration: BoxDecoration(
          color: Colors.redAccent,
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.1), BlendMode.dstATop),
            image: AssetImage('assets/images/mountains.jpg'),
            fit: BoxFit.cover,
          ),
        ),*/
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                textAlign: TextAlign.left,
                style: Style.subtitleTextStyle.copyWith(color: Colors.black87),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.accessibility),
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
                onSubmitted: (String value) {
                  data.saveUser(value);
                  Navigator.pushNamed(context, '/home');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


