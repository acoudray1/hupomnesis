import 'package:flutter/material.dart';
import 'package:hupomnesis/src/views/note_edition_page/note_edition_page_root.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

///
/// Builds a text editor container for note edition
/// 
class BuildTextEditor extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final NoteEditionPageRoot noteEditionPageRoot = NoteEditionPageRoot.of(context);

    ///
    /// Handle the lost of focus on the Keyboard
    ///
    /*void _nodeListener() {
      if(noteEditionPageRoot.noteEditionPageBloc.nodeController.hasFocus) {
        print('Keyboard appeared');
      } else {
        print('Keyboard dissmissed');
      }
    }*/
    final KeyboardVisibilityNotification _keyboardVisibility = KeyboardVisibilityNotification()..addNewListener(
      onChange: (bool visible) {
        print('visible');
      },
    ); 
    int _keyboardVisibilitySubscriberId;

    

    print(_keyboardVisibility.isKeyboardVisible);

    /*KeyboardVisibilityNotification()..addNewListener(
      onChange: (bool visible) {
        print(visible);
      },
      onHide: () => print('Keyboard hidden'),
    );*/

    //noteEditionPageRoot.noteEditionPageBloc.nodeController = FocusNode()..addListener(_nodeListener);

    return SliverFillRemaining(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextField( 
          decoration: InputDecoration.collapsed(
            hintText: noteEditionPageRoot.note.text,
            hintStyle: const TextStyle(fontSize: 24,
              color: Colors.black54,
              fontFamily: 'Roboto-Light'),
            ),
          autofocus: false,
          //focusNode: noteEditionPageRoot.noteEditionPageBloc.nodeController,
          maxLines: null,
          controller: noteEditionPageRoot.noteEditionPageBloc.textEditingController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.newline,
        ),
      ),
    );
  }
}