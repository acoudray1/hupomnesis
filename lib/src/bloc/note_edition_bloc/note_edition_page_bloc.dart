import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hupomnesis/src/model/enum_edition_status.dart';
import 'package:rxdart/rxdart.dart';

///
/// Business Logic class to manage the view for the edition of notes
///
class NoteEditionPageBloc {

  EditionStatus editionStatus = EditionStatus.RENDERING;

  final BehaviorSubject<EditionStatus> _editionStatus = BehaviorSubject<EditionStatus>();
  Observable<EditionStatus> get editionStatusStream => _editionStatus.stream;
  StreamSink<EditionStatus> get editionStatusSink => _editionStatus.sink;

  IconData backIcon = Icons.arrow_back;

  final BehaviorSubject<IconData> _backIcon = BehaviorSubject<IconData>();
  Observable<IconData> get backIconStream => _backIcon.stream;
  StreamSink<IconData> get backIconSink => _backIcon.sink;

  ///
  /// Handle the change of the back icon
  /// 
  void handleTextEdited(String initialText, String newText) {
    if(initialText == newText)
      backIconSink.add(backIcon);
    else 
      backIconSink.add(Icons.done);
  }

  ///
  /// Handle the change to Writing Mode or Rendering Mode
  /// 
  void toggleEditionMode() {
    switch (editionStatus) {
      case EditionStatus.WRITING:
        editionStatus = EditionStatus.RENDERING;
        editionStatusSink.add(editionStatus);
        break;
      case EditionStatus.RENDERING:
        editionStatus = EditionStatus.WRITING;
        editionStatusSink.add(editionStatus);
        break;
    }
  }

  ///
  /// Dispose the different controllers
  ///
  void dispose() {
    _editionStatus.close();
  }
}