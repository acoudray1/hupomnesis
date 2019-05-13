import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hupomnesis/src/model/enum_edition_status.dart';
import 'package:hupomnesis/src/views/note_edition_page/build_writing_mode_bar.dart';
import 'package:hupomnesis/src/views/note_page_root.dart';

import 'build_header.dart';

class NoteEditionPage extends StatelessWidget {
  const NoteEditionPage({Key key, this.index, this.notePageContext}) : super(key: key);

  final int index;
  final BuildContext notePageContext;

  @override
  Widget build(BuildContext context) {
    final NotePageRoot notePageRoot = NotePageRoot.of(notePageContext);
    
    return Scaffold(
      body: Column(
        children: <Widget>[
          BuildHeader(),
          StreamBuilder<EditionStatus>(
            stream: notePageRoot.noteEditionBloc.editionStatusStream,
            initialData: notePageRoot.noteEditionBloc.editionStatus,
            builder: (BuildContext context, AsyncSnapshot<EditionStatus> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data == EditionStatus.WRITING ? BuildWritingModeBar() : Container();
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}