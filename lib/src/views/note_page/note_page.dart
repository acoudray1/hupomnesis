import 'package:flutter/material.dart';
import 'package:hupomnesis/src/bloc/note_bloc/note_bloc.dart';
import 'package:hupomnesis/src/bloc/note_bloc/note_navigation_bloc.dart';
import 'package:hupomnesis/src/bloc/note_bloc/note_page_bloc.dart';
import 'package:hupomnesis/src/views/note_page/build_main_view.dart';
import 'package:hupomnesis/src/views/note_page/note_page_root.dart';

///
/// Note root page
/// 
class NotePage extends StatelessWidget {
  final NoteBloc noteBloc = NoteBloc();
  final NoteNavigationBloc noteNavigationBloc = NoteNavigationBloc();
  final NotePageBloc notePageBloc = NotePageBloc();

  @override
  Widget build(BuildContext context) {
    return NotePageRoot(
      noteBloc: noteBloc,
      noteNavigationBloc: noteNavigationBloc,
      notePageBloc: notePageBloc,
      child: BuildMainView(),
    );
  }
}