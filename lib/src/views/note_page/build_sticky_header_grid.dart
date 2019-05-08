import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:hupomnesis/src/model/note.dart';
import 'package:hupomnesis/src/views/note_page/build_card.dart';
import 'package:hupomnesis/src/views/note_page/note_page_root.dart';
import 'package:hupomnesis/theme/text_style.dart';

///
/// Builds the list of notes as a sliver grid with a sticky header
/// 
class BuildStickyHeaderGrid extends StatelessWidget {

  const BuildStickyHeaderGrid({
    Key key,
    this.title,
    this.notes,
    this.tiles,
  }) : super(key: key);

  final String title;
  final List<Note> notes;
  final List<StaggeredTile> tiles;

  @override
  Widget build(BuildContext context) {
    final NotePageRoot notePageRoot = NotePageRoot.of(context);
    
    return SliverStickyHeader(
      header: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(notes.isNotEmpty ? '$title' : '', style: Style.subtitleTextStyle.copyWith(fontWeight: FontWeight.w500)),
        ),
      ),
      sliver: SliverStaggeredGrid.countBuilder(
        itemBuilder: (BuildContext context, int index) => buildCard(context, index, notes, notePageRoot.noteSelectionBloc),
        itemCount: notes.length,
        crossAxisCount: 4,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
        staggeredTileBuilder: (int index) => notePageRoot.notePageBloc.getTiles(index, tiles),
      ),
    );
  }
}