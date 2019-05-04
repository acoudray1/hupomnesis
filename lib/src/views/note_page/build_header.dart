import 'package:flutter/material.dart';
import 'package:hupomnesis/src/views/note_page/note_page_root.dart';

///
/// Builds the header of the main view
/// 
class BuildHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final NotePageRoot notePageRoot = NotePageRoot.of(context);

    return Column(
      children: <Widget>[
        Container(
          color: Colors.blue,
          height: 24.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // TODO: Send to note creation page
                notePageRoot.noteBloc.createNote('NOTE #TEST', 'Lorem ipsum tititi');
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // TODO: Implement settigs configuration
                notePageRoot.noteBloc.deleteNote(notePageRoot.noteBloc.notes.last);
              },
            )
          ],
        ),
      ],
    );
  }
}