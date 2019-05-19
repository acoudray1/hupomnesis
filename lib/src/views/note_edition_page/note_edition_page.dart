import 'package:flutter/material.dart';
import 'package:hupomnesis/src/bloc/note_bloc/note_bloc.dart';
import 'package:hupomnesis/src/bloc/note_edition_bloc/note_edition_page_bloc.dart';
import 'package:hupomnesis/src/model/enum_status.dart';
import 'package:hupomnesis/src/model/note.dart';
import 'package:hupomnesis/src/views/note_edition_page/build_main_view.dart';
import 'package:hupomnesis/src/views/note_edition_page/note_edition_page_root.dart';

class NoteEditionPage extends StatelessWidget {
  
  NoteEditionPage({
    Key key,
    @required this.status,
    @required this.index,
    @required this.noteBloc,
  }) : super(key: key);

  final NoteBloc noteBloc;
  final int index;
  final Status status;
  final NoteEditionPageBloc noteEditionPageBloc = NoteEditionPageBloc();

  @override
  Widget build(BuildContext context) {
    Note note;
    // Depending on the status and the index we access to the right note
    switch (status) {
      case Status.PINNED:
        note = noteBloc.pinnedNotes[index];
        break;
      case Status.NORMAL:
        note = noteBloc.normalNotes[index];
        break;
      case Status.ARCHIVED:
        note = noteBloc.archivedNotes[index];
        break;
    }

    return NoteEditionPageRoot(
      noteEditionPageBloc: noteEditionPageBloc,
      index: index,
      status: status,
      noteBloc: noteBloc,
      note: note,
      child: BuildMainView(text: note.text,),
    );
  }
}