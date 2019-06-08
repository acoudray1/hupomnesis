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
  Color _noteColor;
  Color _borderColor;
  double _borderWidth;
  double _elevation;

  return StreamBuilder<bool>(
    stream: noteSelectionBloc.isSelectingStream,
    initialData: notes[index].isSelected,
    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
      if (snapshot.hasData) {
        switch (notes[index].colorSelected) {
          case ColorSelected.BLUE:
            _noteColor = Colors.blue.shade300;
            break;
          case ColorSelected.PURPLE:
            _noteColor = Colors.purple.shade300;
            break;
          case ColorSelected.GREEN:
            _noteColor = Colors.green.shade300;
            break;
          case ColorSelected.YELLOW:
            _noteColor = Colors.yellow.shade300;
            break;
          case ColorSelected.RED:
            _noteColor = Colors.red.shade300;
            break;
          case ColorSelected.NORMAL:
            _noteColor = Colors.white;
            break;
          default:
            _noteColor = Colors.white;
            break;
        }

        if (notes[index].isSelected) {
          _borderColor = Theme.of(context).accentColor;
          _borderWidth = 2.5;
          _elevation = 3.0;
        } else if (!notes[index].isSelected) {
          _borderColor = Theme.of(context).toggleableActiveColor;
          _borderWidth = 1.0;
          _elevation = 0.0;
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
                  color: _noteColor,
                  child: InkWell(
                    splashColor: Colors.pinkAccent.withAlpha(70),
                    // TODO(interactions): Implement actions
                    onTap: () => snapshot.data 
                      ? noteSelectionBloc.handleNoteToggle(notes[index]) 
                      : Navigator.of(context).push(MaterialPageRoute<NoteEditionPage>(
                        builder: (BuildContext context) => NoteEditionPage(
                          note: notes[index],
                          noteBloc: noteBloc,
                        ))),
                    onLongPress: () => noteSelectionBloc.handleNoteToggle(notes[index]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Wrap(
                        children: <Widget>[
                          // For informations about color selected or notifications
                          /* notes[index].colorSelected != ColorSelected.NORMAL 
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const SizedBox(width: 13.0),
                              Icon(Icons.brightness_1, color: _noteColor,),
                            ],
                          ) : Container(),*/
                          //const SizedBox(height: 2.0,),
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