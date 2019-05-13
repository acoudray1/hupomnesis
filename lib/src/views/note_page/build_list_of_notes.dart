import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hupomnesis/src/views/note_page/build_sticky_header_grid.dart';
import 'package:hupomnesis/src/views/note_page_root.dart';

///
/// Builds the list of notes with a stream builder attached to NavigationBloc
/// Depending on the status we get in stream, it displays a list of notes
/// 
class BuildListOfNotes extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final NotePageRoot notePageRoot = NotePageRoot.of(context);
    final List<StaggeredTile> pinnedTiles 
      = notePageRoot.notePageBloc.generateRandomTiles(notePageRoot.noteBloc.pinnedNotes.length).toList();
    final List<StaggeredTile> normalTiles 
      = notePageRoot.notePageBloc.generateRandomTiles(notePageRoot.noteBloc.normalNotes.length).toList();
    final List<StaggeredTile> archivedTiles 
      = notePageRoot.notePageBloc.generateRandomTiles(notePageRoot.noteBloc.archivedNotes.length).toList();

    return CustomScrollView(
      slivers: <Widget>[
        BuildStickyHeaderGrid(title: 'PINNED', notes: notePageRoot.noteBloc.pinnedNotes, tiles: pinnedTiles,),
        BuildStickyHeaderGrid(title: 'NORMAL', notes: notePageRoot.noteBloc.normalNotes, tiles: normalTiles,),
        BuildStickyHeaderGrid(title: 'ARCHIVED', notes: notePageRoot.noteBloc.archivedNotes, tiles: archivedTiles,),
      ]
    );
  }
}