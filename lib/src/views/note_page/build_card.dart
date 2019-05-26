import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hupomnesis/src/bloc/note_bloc/note_bloc.dart';
import 'package:hupomnesis/src/bloc/note_bloc/note_selection_bloc.dart';
import 'package:hupomnesis/src/model/enum_color_selected.dart';
import 'package:hupomnesis/src/model/enum_status.dart';
import 'package:hupomnesis/src/model/note.dart';
import 'package:hupomnesis/src/views/note_edition_page/note_edition_page.dart';

///
/// Widget that builds a card
/// 
Widget buildCard(BuildContext context, int index, List<Note> notes, NoteSelectionBloc noteSelectionBloc, Status status, NoteBloc noteBloc) {
  Color _borderColor = Colors.grey;
  double _borderWidth = 1.0;
  Color _noteColor;
  double _elevation = 0.0;

  return StreamBuilder<bool>(
    stream: noteSelectionBloc.isSelectingStream,
    initialData: notes[index].isSelected,
    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
      if (snapshot.hasData) {
        if (notes[index].isSelected) {
          _borderColor = Colors.blue;
          _borderWidth = 2.5;
          _elevation = 3.0;
        } else if (!notes[index].isSelected) {
          _borderColor = Colors.grey;
          _borderWidth = 1.0;
          _elevation = 0.0;
        }

        switch (notes[index].colorSelected) {
          case ColorSelected.BLUE:
            _noteColor = Colors.blue;
            break;
          case ColorSelected.PURPLE:
            _noteColor = Colors.purple;
            break;
          case ColorSelected.GREEN:
            _noteColor = Colors.green;
            break;
          case ColorSelected.YELLOW:
            _noteColor = Colors.yellow;
            break;
          case ColorSelected.RED:
            _noteColor = Colors.red;
            break;
          case ColorSelected.NORMAL:
            _noteColor = Colors.transparent;
            break;
          default:
            _noteColor = Colors.transparent;
            break;
        }

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
                  elevation: _elevation,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: _borderColor, width: _borderWidth),
                    borderRadius: BorderRadius.circular(6.0)
                  ),
                  color: Colors.white,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(70),
                    // TODO(interactions): Implement actions
                    onTap: () => snapshot.data 
                      ? noteSelectionBloc.handleNoteToggle(notes[index]) 
                      : Navigator.of(context).push(MaterialPageRoute<NoteEditionPage>(
                        builder: (BuildContext context) => NoteEditionPage(
                          note: notes[index],
                          noteBloc: noteBloc,
                        ))),
                    onLongPress: () => noteSelectionBloc.handleNoteSelection(notes[index]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Wrap(
                        children: <Widget>[
                          notes[index].colorSelected != ColorSelected.NORMAL 
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const SizedBox(width: 13.0),
                              Icon(Icons.brightness_1, color: _noteColor,),
                            ],
                          ) : Container(),
                          const SizedBox(height: 2.0,),
                          MarkdownBody(data: notes[index].text,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return Container();
      }
    },
  );
}