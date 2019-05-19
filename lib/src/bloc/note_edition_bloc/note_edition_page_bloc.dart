import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hupomnesis/src/model/enum_edition_status.dart';
import 'package:rxdart/rxdart.dart';

///
/// Business Logic class to manage the view for the edition of notes
///
class NoteEditionPageBloc {

  EditionStatus editionStatus = EditionStatus.WRITING;

  final BehaviorSubject<EditionStatus> _editionStatus = BehaviorSubject<EditionStatus>();
  Observable<EditionStatus> get editionStatusStream => _editionStatus.stream;
  StreamSink<EditionStatus> get editionStatusSink => _editionStatus.sink;

  TextEditingController textEditingController = TextEditingController();

  ///
  /// Handle the change to Writing Mode or Rendering Mode
  /// 
  void toggleEditionMode() {
    switch (editionStatus) {
      case EditionStatus.RENDERING:
        editionStatus = EditionStatus.RENDERING;
        editionStatusSink.add(editionStatus);
        break;
      case EditionStatus.WRITING:
        editionStatus = EditionStatus.WRITING;
        editionStatusSink.add(editionStatus);
        break;
    }
  }

  ///
  /// Update the textController data
  ///
  void updateText(String text) {
    textEditingController.text = text;
    print(textEditingController.text);
  }

  ///
  /// Handle the Navigator.pop
  ///
  Future<bool> saveAndPop() async {
    print('hello');
    return true;
  }

  ///
  /// Dispose the different controllers
  ///
  void dispose() {
    _editionStatus.close();
    textEditingController.dispose();
  }
}