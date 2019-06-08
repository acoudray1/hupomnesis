import 'package:flutter/material.dart';
import 'package:hupomnesis/theme/style_texte.dart';

class BuildEmptyListOfNotes extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height * 0.4),
        Center(child: Text('No notes is created :\'(\nCreate a new one !', textAlign: TextAlign.center, style: Style.subtitleTextStyle.copyWith(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,),)),
        // TODO(axelc): Add sad image
      ],
    );
  }
}