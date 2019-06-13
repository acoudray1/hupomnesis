import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:hupomnesis/src/model/enum_status.dart';
import 'package:hupomnesis/src/model/note.dart';
import 'package:hupomnesis/src/views/note_page/build_card.dart';
import 'package:hupomnesis/src/views/note_page/note_page_root.dart';
import 'package:hupomnesis/theme/style_texte.dart';

///
/// Builds the list of notes as a sliver grid with a sticky header
/// 
class BuildStickyHeaderGrid extends StatelessWidget {

  const BuildStickyHeaderGrid({
    Key key,
    this.title,
    this.notes,
    this.tiles,
    this.status,
  }) : super(key: key);

  final String title;
  final List<Note> notes;
  final List<StaggeredTile> tiles;
  final Status status;

  @override
  Widget build(BuildContext context) {
    final NotePageRoot notePageRoot = NotePageRoot.of(context);
    
    return SliverStickyHeader(
      header: Container(
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(notes.isNotEmpty ? '$title' : '', style: Style.commonTextStyle.copyWith(fontWeight: FontWeight.w500, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
        ),
      ),
      sliver: SliverStaggeredGrid.countBuilder(
        itemBuilder: (BuildContext context, int index) =>
          buildCard(context, index, notes, notePageRoot.noteSelectionBloc, status, notePageRoot.noteBloc),
        itemCount: notes.length,
        crossAxisCount: 4,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
        staggeredTileBuilder: (int index) => notePageRoot.notePageBloc.getTiles(index, tiles),
      ),
    );
  }
}