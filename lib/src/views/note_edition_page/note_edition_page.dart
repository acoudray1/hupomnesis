import 'package:flutter/material.dart';
import 'package:hupomnesis/src/bloc/note_bloc/note_bloc.dart';
import 'package:hupomnesis/src/bloc/note_edition_bloc/note_edition_page_bloc.dart';
import 'package:hupomnesis/src/model/enum_edition_status.dart';
import 'package:hupomnesis/src/model/note.dart';
import 'package:hupomnesis/src/views/note_edition_page/build_main_view.dart';
import 'package:hupomnesis/src/views/note_edition_page/note_edition_page_root.dart';

class NoteEditionPage extends StatelessWidget {
  
  NoteEditionPage({
    Key key,
    this.note,
    @required this.noteBloc,
  }) : super(key: key);

  final NoteBloc noteBloc;
  final Note note;
  final NoteEditionPageBloc noteEditionPageBloc = NoteEditionPageBloc();

  @override
  Widget build(BuildContext context) {

    return note == null 
      ? NoteEditionPageRoot(
        noteEditionPageBloc: noteEditionPageBloc,
        noteBloc: noteBloc,
        editionStatus: EditionStatus.WRITING,
        child: const BuildMainView(text: '',),
      )
      : NoteEditionPageRoot(
        noteEditionPageBloc: noteEditionPageBloc,
        noteBloc: noteBloc,
        editionStatus: EditionStatus.RENDERING,
        note: note,
        child: BuildMainView(text: note.text,),
    );
  }
}