import 'package:flutter/material.dart';
import 'package:hupomnesis/src/bloc/note_bloc/note_bloc.dart';
import 'package:hupomnesis/src/bloc/note_bloc/note_page_bloc.dart';
import 'package:hupomnesis/src/bloc/note_bloc/note_selection_bloc.dart';
import 'package:hupomnesis/src/bloc/note_edition_bloc/note_edition_page_bloc.dart';
import 'package:hupomnesis/src/views/note_page/build_main_view.dart';
import 'package:hupomnesis/src/views/note_page/note_page_root.dart';

///
/// Note root page
/// 
class NotePage extends StatelessWidget {
  final NoteBloc noteBloc = NoteBloc();
  final NotePageBloc notePageBloc = NotePageBloc();
  final NoteSelectionBloc noteSelectionBloc = NoteSelectionBloc();
  final NoteEditionPageBloc noteEditionPageBloc = NoteEditionPageBloc();

  @override
  Widget build(BuildContext context) {
    noteBloc.getNotesFromDatabase();
    print('hello');

    return NotePageRoot(
      noteBloc: noteBloc,
      notePageBloc: notePageBloc,
      noteSelectionBloc: noteSelectionBloc,
      child: BuildMainView(),
    );
  }
}

