import 'package:flutter/material.dart';

class BuildEmptyListOfNotes extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height * 0.4),
        Center(child: const Text('No notes is created :\'(\nCreate a new one !', textAlign: TextAlign.center,)),
        // TODO(axelc): Add sad image
      ],
    );
  }
}