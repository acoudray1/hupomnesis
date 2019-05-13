import 'package:flutter/material.dart';
import 'package:hupomnesis/src/model/note.dart';
import 'package:hupomnesis/src/views/note_page/build_empty_list_of_notes.dart';
import 'package:hupomnesis/src/views/note_page/build_header.dart';
import 'package:hupomnesis/src/views/note_page/build_list_of_notes.dart';
import 'package:hupomnesis/src/views/note_page_root.dart';

///
/// Builds the main view of the note display
/// 
/// Widget Tree : **NotePage** -> **BuildMainView**
///                                        -> **BuildHeader**
///                                        -> noteBloc.notes.isNotEmpty() 
///                                           ? **BuildListOfNotes**
///                                                  -> **BuildStickyHeaderGrid**
///                                                          -> BuildCard()
///                                           : **BuildEmptyListOfNotes**
///                                                  -> 
///                                        -> **BuildBottomNavBar**
class BuildMainView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final NotePageRoot notePageRoot = NotePageRoot.of(context);
    notePageRoot.noteBloc.bfetchNotesFromJson();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[ 
          // Builds the header
          BuildHeader(),
          // Builds the list of notes
          Expanded(
            child: StreamBuilder<List<Note>>(
              stream: notePageRoot.noteBloc.notesStream,
              initialData: notePageRoot.noteBloc.notes,
              builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
                if (snapshot.hasData) {
                  return notePageRoot.noteBloc.notes.isNotEmpty ? BuildListOfNotes() : BuildEmptyListOfNotes();
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}