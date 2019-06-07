import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hupomnesis/src/views/note_page/note_page.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void main() {
  runApp(Hupomnesis());
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
}

///
/// Entry point for flutter app Hupomnesis
/// 
class Hupomnesis extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (Brightness brightness) => ThemeData(
        primarySwatch: Colors.indigo,
        backgroundColor: Colors.blueGrey,
        brightness: brightness,
      ),
      themedWidgetBuilder: (BuildContext context, ThemeData theme) {
        return MaterialApp(
          title: 'Hupomnesis',
          home: NotePage(),
          theme: theme,
        );
      },
    );
  }
}
