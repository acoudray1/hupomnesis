import 'package:flutter/material.dart';
import 'package:hupomnesis/src/views/note_page/note_page_root.dart';

///
/// Builds the header of the main view
/// 
class BuildHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final NotePageRoot notePageRoot = NotePageRoot.of(context);


    return StreamBuilder<bool>(
      stream: notePageRoot.noteSelectionBloc.isSelectingStream,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if(snapshot.hasData) {
          switch (snapshot.data) {
            case true:
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
                  ),
                  const SizedBox(height: 1.0,)
                ],
              );
              break;
            case false:
              return Column(
                children: <Widget>[
                  Container(
                    color: Colors.blue,
                    height: 24.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          // TODO(onPressed): Send to note creation page
                          notePageRoot.noteBloc.createNote('NOTE #TEST', 'Lorem ipsum tititi');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {
                          // TODO(onPressed): Implement settigs configuration
                          notePageRoot.noteBloc.deleteNote(notePageRoot.noteBloc.notes.last);
                        },
                      )
                    ],
                  ),
                ],
              );
              break;
          }
        } else {
          return Container();
        }
      }
    );
  }
}