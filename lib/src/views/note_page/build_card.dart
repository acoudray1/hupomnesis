import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hupomnesis/src/bloc/note_bloc/note_selection_bloc.dart';
import 'package:hupomnesis/src/model/note.dart';
import 'package:hupomnesis/theme/text_style.dart';

///
/// Widget that builds a card
/// 
Widget buildCard(BuildContext context, int index, List<Note> notes, NoteSelectionBloc noteSelectionBloc) {
  Color _color = Colors.grey;

  return StreamBuilder<bool>(
    stream: noteSelectionBloc.isSelectingStream,
    initialData: notes[index].isSelected,
    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
      if (snapshot.hasData) {
        notes[index].isSelected ? _color = Colors.blue : _color = Colors.grey;
        return Padding(
          padding: const EdgeInsets.fromLTRB(1.0, 2.0, 0.0, 2.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 2.0,
                bottom: 2.0,
                left: 2.0,
                right: 2.0,
                child: Card(
                  elevation: notes[index].isSelected ? 3 : 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: _color, width: 1.0),
                    borderRadius: BorderRadius.circular(6.0)
                  ),
                  color: Colors.white,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(70),
                    // TODO(interactions): Implement actions
                    onTap: () => snapshot.data ? noteSelectionBloc.handleNoteToggle(notes[index]) : true,
                    onLongPress: () => noteSelectionBloc.handleNoteSelection(notes[index]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${notes[index].name}', style: Style.subtitleTextStyle, textAlign: TextAlign.start,),
                          const SizedBox(height: 1.0,),
                          Text('${notes[index].text}', style: Style.commonTextStyle, textAlign: TextAlign.justify,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              notes[index].isSelected ? Positioned(
                top: 10.0,
                bottom: 10.0,
                left: 10.0,
                right: 10.0,
                child: GestureDetector(
                  onTap: () => noteSelectionBloc.handleNoteToggle(notes[index]),
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                      child: Container(
                        //padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
              ) : Container(),
            ],
          ),
        );
      } else {
        return Container();
      }
    },
  );
}