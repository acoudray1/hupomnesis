import 'package:flutter/material.dart';
import 'package:hupomnesis/src/bloc/note_bloc/note_bloc.dart';
import 'package:hupomnesis/src/bloc/note_bloc/note_page_bloc.dart';
import 'package:hupomnesis/src/bloc/note_bloc/note_selection_bloc.dart';

///
/// This class is the root of the note page
/// This is the first ancestor of the widget tree
/// 
class NotePageRoot extends InheritedWidget {

  const NotePageRoot({
    Key key,
    this.noteBloc,
    this.notePageBloc,
    this.noteSelection,
    Widget child,
  }) : super(key: key, child: child);

  final NoteBloc noteBloc;
  final NotePageBloc notePageBloc;
  final NoteSelection noteSelection;
  
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static NotePageRoot of(BuildContext context) => context.inheritFromWidgetOfExactType(NotePageRoot);
  
}
