import 'package:flutter/material.dart';
import 'package:hupomnesis/src/model/enum_edition_status.dart';
import 'package:hupomnesis/src/views/note_edition_page/build_header.dart';
import 'package:hupomnesis/src/views/note_edition_page/build_writing_mode_bar.dart';
import 'package:hupomnesis/src/views/note_edition_page/note_edition_page_root.dart';

class BuildMainView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final NoteEditionPageRoot noteEditionPageRoot = NoteEditionPageRoot.of(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          BuildHeader(),
          StreamBuilder<EditionStatus>(
            stream: noteEditionPageRoot.noteEditionPageBloc.editionStatusStream,
            initialData: noteEditionPageRoot.noteEditionPageBloc.editionStatus,
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