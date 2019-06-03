import 'package:flutter/material.dart';
import 'package:hupomnesis/src/views/note_page/note_page_root.dart';

class BuildEmptyListOfNotes extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final NotePageRoot notePageRoot = NotePageRoot.of(context);

    return Column(
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height * 0.4),
        Center(child: const Text('There was no data in the file')),
        const SizedBox(height: 12.0,),
        FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            notePageRoot.noteBloc.createNote('# Hello I am a note');
          },
        ),
      ],
    );
  }
}