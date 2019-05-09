import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hupomnesis/src/model/enum_color_selected.dart';
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        notePageRoot.noteSelectionBloc.handleCompleteDiscard(notePageRoot.noteBloc.notes);
                      },
                    ),
                    Text('${notePageRoot.noteSelectionBloc.numberOfNotesSelected}', 
                      style: Style.subtitleTextStyle.copyWith(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 18),),
                    const SizedBox(width: 100.0),
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
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<ColorSelected>> [
                        // TODO(later): /!\ REFACTOR THIS /!\
                        PopupMenuItem<ColorSelected>(
                          value: ColorSelected.BLUE,
                          height: 35.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 1.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        const PopupMenuDivider(height: 12.0,),
                        PopupMenuItem<ColorSelected>(
                          value: ColorSelected.GREEN,
                          height: 35.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 1.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        const PopupMenuDivider(height: 12.0,),
                        PopupMenuItem<ColorSelected>(
                          value: ColorSelected.YELLOW,
                          height: 35.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 1.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                        const PopupMenuDivider(height: 12.0,),
                        PopupMenuItem<ColorSelected>(
                          value: ColorSelected.PURPLE,
                          height: 35.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 1.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                        const PopupMenuDivider(height: 12.0,),
                        PopupMenuItem<ColorSelected>(
                          value: ColorSelected.RED,
                          height: 35.0,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                          ),
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
                        notePageRoot.noteBloc.createNote('NOTE #TEST-${random.nextInt(99)}', 'Lorem ipsum tititi');
                      },
                      child: Text('Create a new note...', style: Style.commonTextStyle.copyWith(color: Colors.grey),),
                    ),
                    IconButton(
                      icon: const Icon(Icons.import_export),
                      onPressed: () {
                        // TODO(onPressed): Implement settigs configuration
                        notePageRoot.noteBloc.deleteNote(note: notePageRoot.noteBloc.notes.last);
                      },
                    )
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
}