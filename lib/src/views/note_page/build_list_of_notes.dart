import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hupomnesis/src/model/enum_status.dart';
import 'package:hupomnesis/src/views/note_page/build_sticky_header_grid.dart';
import 'package:hupomnesis/src/views/note_page/note_page_root.dart';

///
/// Builds the list of notes with a stream builder attached to NavigationBloc
/// Depending on the status we get in stream, it displays a list of notes
/// 
class BuildListOfNotes extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final NotePageRoot notePageRoot = NotePageRoot.of(context);
    final List<StaggeredTile> pinnedTiles 
      = notePageRoot.notePageBloc.generateTiles(notePageRoot.noteBloc.pinnedNotes.length, notePageRoot.noteBloc.pinnedNotes).toList();
    final List<StaggeredTile> normalTiles 
      = notePageRoot.notePageBloc.generateTiles(notePageRoot.noteBloc.normalNotes.length, notePageRoot.noteBloc.normalNotes).toList();
    final List<StaggeredTile> archivedTiles 
      = notePageRoot.notePageBloc.generateTiles(notePageRoot.noteBloc.archivedNotes.length, notePageRoot.noteBloc.archivedNotes).toList();

    return CustomScrollView(
      slivers: <Widget>[
        notePageRoot.noteBloc.pinnedNotes.isEmpty ? SliverToBoxAdapter( child: Container()) : BuildStickyHeaderGrid(title: 'PINNED', notes: notePageRoot.noteBloc.pinnedNotes, tiles: pinnedTiles, status: Status.PINNED,),
        notePageRoot.noteBloc.normalNotes.isEmpty ? SliverToBoxAdapter( child: Container()) : BuildStickyHeaderGrid(title: 'NORMAL', notes: notePageRoot.noteBloc.normalNotes, tiles: normalTiles, status: Status.NORMAL,),
        notePageRoot.noteBloc.archivedNotes.isEmpty ? SliverToBoxAdapter( child: Container()) : BuildStickyHeaderGrid(title: 'ARCHIVED', notes: notePageRoot.noteBloc.archivedNotes, tiles: archivedTiles, status: Status.ARCHIVED,),
      ]
    );
  }
}