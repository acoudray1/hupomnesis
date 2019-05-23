import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hupomnesis/src/model/enum_color_selected.dart';
import 'package:hupomnesis/src/model/enum_status.dart';
import 'package:hupomnesis/src/views/note_edition_page/note_edition_page.dart';
import 'package:hupomnesis/src/views/note_page/note_page_root.dart';
import 'package:hupomnesis/theme/style_icons.dart';
import 'package:hupomnesis/theme/style_texte.dart';

///
/// Builds the header of the main view
/// 
class BuildHeader extends StatelessWidget {
  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    final NotePageRoot notePageRoot = NotePageRoot.of(context);

    return StreamBuilder<bool>(
      stream: notePageRoot.noteSelectionBloc.isSelectingStream,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if(snapshot.hasData) {
          return Column(
            children: <Widget>[
              Container(
                color: Colors.blue,
                height: 24.0,
              ),
              AnimatedContainer(
                height: 72,
                duration: Duration(seconds: 1),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(offset: const Offset(0, 0.2), color: Colors.grey)
                  ]
                ),
                child: snapshot.data 
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            notePageRoot.noteSelectionBloc.handleCompleteDiscard(notePageRoot.noteBloc.notes);
                          },
                        ),
                        Text('${notePageRoot.noteSelectionBloc.numberOfNotesSelected}', 
                          style: Style.subtitleTextStyle.copyWith(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ]
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon:  const Icon(StyleIcons.pin),
                          onPressed: () =>
                            notePageRoot.noteBloc.noteToPinned(listOfNotes: notePageRoot.noteBloc.notes, noteSelectionBloc: notePageRoot.noteSelectionBloc),
                        ),
                        IconButton(
                          icon: const Icon(Icons.archive),
                          onPressed: () =>
                            notePageRoot.noteBloc.noteToArchived(listOfNotes: notePageRoot.noteBloc.notes, noteSelectionBloc: notePageRoot.noteSelectionBloc),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                            notePageRoot.noteBloc.deleteNote(listOfNotes: notePageRoot.noteBloc.notes, noteSelectionBloc: notePageRoot.noteSelectionBloc),
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications),
                          onPressed: () => true,
                        ),
                        PopupMenuButton<ColorSelected>(
                          icon: const Icon(Icons.color_lens),
                          offset: const Offset(100,100),
                          padding: const EdgeInsets.all(0.0),
                          tooltip: 'Choose a color for your notes!',
                          onSelected: (ColorSelected colorSelected) => 
                            notePageRoot.noteBloc.changeColor(listOfNotes: notePageRoot.noteBloc.notes, noteSelectionBloc: notePageRoot.noteSelectionBloc, colorSelected: colorSelected),
                          itemBuilder: (BuildContext context) => <PopupMenuEntry<ColorSelected>> [
                            buildPopupMenuItem(ColorSelected.YELLOW, 'YELLOW', Colors.yellow),
                            buildPopupMenuItem(ColorSelected.BLUE, 'BLUE', Colors.blue),
                            buildPopupMenuItem(ColorSelected.GREEN, 'GREEN', Colors.green),
                            buildPopupMenuItem(ColorSelected.PURPLE, 'PURPLE', Colors.purple),
                            buildPopupMenuItem(ColorSelected.RED, 'RED', Colors.red),
                          ],
                        ),
                      ],
                    ),
                  ],
                ) : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    MaterialButton(
                      height: 72,
                      onPressed: () {
                        // TODO(onPressed): Send to note creation page
                        //notePageRoot.noteBloc.createNote('Lorem ipsum tititi');
                        Navigator.of(context).push(MaterialPageRoute<NoteEditionPage>(
                          builder: (BuildContext context) => NoteEditionPage(
                            status: Status.NORMAL,
                            noteBloc: notePageRoot.noteBloc,
                          )));
                      },
                      child: Text('Create a new note...', style: Style.commonTextStyle.copyWith(color: Colors.grey),),
                    ),
                    // SizedBox(width: MediaQuery.of(context).size.width*0.3),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.brightness_2),
                          onPressed: () {
                            // TODO(onPressed): Implement dark mode
                            notePageRoot.noteBloc.deleteNote(note: notePageRoot.noteBloc.notes.last);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.import_export),
                          onPressed: () {
                            // TODO(onPressed): Implement import / export
                            notePageRoot.noteBloc.deleteNote(note: notePageRoot.noteBloc.notes.last);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 1.0,)
            ],
          );
        } else {
          return Container();
        }
      }
    );
  }

  ///
  /// Function that builds PopupMenuItem for PopupMenuButton
  /// 
  PopupMenuItem<ColorSelected> buildPopupMenuItem(ColorSelected colorSelected, String textToDisplay, Color color) {

    return PopupMenuItem<ColorSelected>(
      value: colorSelected,
      child: ListTile(
        leading: Icon(Icons.brightness_1, color: color,),
        title: Text('$textToDisplay', style: Style.smallTextStyle.copyWith(color: Colors.black54),),
      ),
    );
  }
}