import 'package:flutter/material.dart';
import 'package:hupomnesis/src/bloc/note_bloc/note_navigation_bloc.dart';
import 'package:hupomnesis/src/views/note_page/build_sticky_header_grid.dart';
import 'package:hupomnesis/src/views/note_page/note_page_root.dart';

class BuildListOfNotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NotePageRoot notePageRoot = NotePageRoot.of(context);
    
    return StreamBuilder<StatusToShow>(
      initialData: StatusToShow.NORMAL,
      stream: notePageRoot.noteNavigationBloc.notesToShowStream,
      builder: (BuildContext context, AsyncSnapshot<StatusToShow> snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data) {
            case StatusToShow.PINNED:
              return const BuildStickyHeaderGrid();
              break;
            case StatusToShow.NORMAL:
              return const BuildStickyHeaderGrid();
              break;
            case StatusToShow.ARCHIVED:
              return const BuildStickyHeaderGrid();
              break;
            default:
          }
        } else {
          return Container();
        }
      },
    );
  }
}