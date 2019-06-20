import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:hupomnesis/src/bloc/note_bloc/note_bloc.dart';
import 'package:hupomnesis/src/model/note.dart';
import 'package:hupomnesis/src/views/note_edition_page/note_edition_page.dart';
import 'package:hupomnesis/src/views/note_page/build_empty_list_of_notes.dart';
import 'package:hupomnesis/src/views/note_page/build_header.dart';
import 'package:hupomnesis/src/views/note_page/build_list_of_notes.dart';
import 'package:hupomnesis/src/views/note_page/note_page_root.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// Builds the main view of the note display
/// 
class BuildMainView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final NotePageRoot notePageRoot = NotePageRoot.of(context);
    onStart(notePageRoot.noteBloc);
    notePageRoot.noteBloc.getNotesFromDatabase();

    FlutterStatusbarcolor.setStatusBarColor(Theme.of(context).primaryColor);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : const Color(0xFF202124),
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return RadialGradient(
              center: Alignment.center,
              radius: 0.5,
              colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).buttonColor,
              ],
              tileMode: TileMode.mirror,
            ).createShader(bounds);
          },
          child: const Icon(Icons.add),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<NoteEditionPage>(
            builder: (BuildContext context) => NoteEditionPage(
              noteBloc: notePageRoot.noteBloc,
            )));
        },
      ),
      body: SafeArea(
        top: true,
        child: Column(
          children: <Widget>[ 
            // Builds the header
            BuildHeader(),
            // Builds the list of notes
            Expanded(
              child: StreamBuilder<List<Note>>(
                stream: notePageRoot.noteBloc.notesStream,
                initialData: notePageRoot.noteBloc.notes,
                builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data.isNotEmpty ? BuildListOfNotes() : BuildEmptyListOfNotes();
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> onStart(NoteBloc noteBloc) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  const String _markdownData = '''
  # Click me to see what you can do!
  Markdown allows you to easily include formatted text, images, and even formatted code.
  Write your notes in markdown and see how it looks by clicking the eye above. 

  Here is a quick demo of what you can do:
  
  ### Emphasis
  **bold**
  __bold__
  *italics*
  _italics_
  ~~strikethrough~~

  ---

  ### Headers
  # Big header
  ## Medium header
  ### Small header
  #### Tiny header
  ##### Tiny tiny header
  ###### Tiny tiny tiny header

  ---

  ### Horizontal rules
  ___
  ---
  ***

  ---

  ### Lists
  * Create a list by starting a line with '+', '-', or '*'
  * Sub-lists are made by indentng 2 spaces:
    + Generic list item
    - Generic list item

  1. Create ordered lists with numbers
  2. Numbered list item
  3. Numbered list item</pre>

  ---

  ### Links
  [Text to display](http://www.example.com)

  ---

  ### Images
  ![Minion](https://octodex.github.com/images/minion.png "The minion")
  ![Stormtroopocat](https://octodex.github.com/images/stormtroopocat.jpg "The Stormtroopocat")
  ![Dojocat](https://octodex.github.com/images/dojocat.jpg  "The Dojocat")

  ---

  ### Quotes
  > This is a quote.
  > It can span multiple lines!
  >> It can be nested by using more signs like this!
  >>> And like this!!!

  ---

  ### Displaying code
  Inline `code`

  Code highlighting like that:
  ```
  var foo = function(bar) {
    return bar++;
  };
  console.log(foo(5));
  ```

  Start Writting your notes with markdown now!
  ''';

  final bool appStarted = prefs.getBool('app_started') ?? false;

  if(!appStarted) {
    noteBloc.createNote(_markdownData);
    prefs.setBool('app_started', true);
  }
}