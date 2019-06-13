import 'package:flutter/material.dart';
import 'package:hupomnesis/src/bloc/note_bloc/note_bloc.dart';
import 'package:hupomnesis/src/bloc/note_edition_bloc/note_edition_page_bloc.dart';
import 'package:hupomnesis/src/model/enum_edition_status.dart';
import 'package:hupomnesis/src/model/note.dart';

///
/// This class is the root of the note edition page
/// This is the first ancestor of the widget tree
/// 
class NoteEditionPageRoot extends InheritedWidget {

  NoteEditionPageRoot({
    Key key,
    @required this.noteEditionPageBloc,
    @required this.noteBloc,
    @required this.editionStatus,
    this.note,
    Widget child,
  }) : super(key: key, child: child);

  final NoteBloc noteBloc;
  final NoteEditionPageBloc noteEditionPageBloc;
  final EditionStatus editionStatus;
  final Note note;
  
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static NoteEditionPageRoot of(BuildContext context) => context.inheritFromWidgetOfExactType(NoteEditionPageRoot);
}