import 'package:flutter/material.dart';
import 'package:hupomnesis/src/views/note_edition_page/note_edition_page.dart';
import 'package:hupomnesis/src/views/note_page/note_page_root.dart';
import 'package:hupomnesis/theme/style_texte.dart';

class BuildEmptyListOfNotes extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final NotePageRoot notePageRoot = NotePageRoot.of(context);
    
    return Column(
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height * 0.38),
        Center(
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).buttonColor,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute<NoteEditionPage>(
                          builder: (BuildContext context) => NoteEditionPage(
                            noteBloc: notePageRoot.noteBloc,
                          )));
            },
            child: Icon(Icons.add, color: Theme.of(context).canvasColor,),
            elevation: 0.0,
          ),
        ),
        const SizedBox(height: 15,),
        Center(child: Text('Start writing notes!', textAlign: TextAlign.center, style: Style.subtitleTextStyle.copyWith(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,),)),
        // TODO(axelc): Add sad image
      ],
    );
  }
}