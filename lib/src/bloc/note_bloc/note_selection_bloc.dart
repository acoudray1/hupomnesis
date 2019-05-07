import 'dart:async';

import 'package:hupomnesis/src/model/note.dart';
import 'package:rxdart/rxdart.dart';

class NoteSelection {

  final BehaviorSubject<bool> _isSelecting = BehaviorSubject<bool>();
  Observable<bool> get isSelectingStream => _isSelecting.stream;
  StreamSink<bool> get isSelectingSink => _isSelecting.sink;

  ///
  /// handle the long press on a note 
  /// 
  void handleSelection(Note note) {
    note.isSelected = true;
    isSelectingSink.add(true);
  }

  ///
  /// handle the discard on a note 
  /// 
  void handleDiscard(Note note) {
    note.isSelected = false;
    isSelectingSink.add(true);
  }

  ///
  /// handle the toggle of a note
  /// 
  void handleToggle(Note note) {
    switch (note.isSelected) {
      case true:
        isSelectingSink.add(false);
        note.isSelected = false;
        break;
      case false:
        isSelectingSink.add(true);
        note.isSelected = true;
        break;
    }
  }
}