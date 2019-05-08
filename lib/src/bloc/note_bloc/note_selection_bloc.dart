import 'dart:async';

import 'package:hupomnesis/src/model/note.dart';
import 'package:rxdart/rxdart.dart';

class NoteSelection {

  final BehaviorSubject<bool> _isSelecting = BehaviorSubject<bool>();
  Observable<bool> get isSelectingStream => _isSelecting.stream;
  StreamSink<bool> get isSelectingSink => _isSelecting.sink;

  int numberOfNotesSelected = 0;

  ///
  /// handle the long press on a note 
  /// 
  void handleNoteSelection(Note note) {
    note.isSelected = true;
    numberOfNotesSelected++;
    isSelectingSink.add(true);
  }

  ///
  /// handle the discard on a note 
  /// 
  void handleNoteDiscard(Note note) {
    note.isSelected = false;
    numberOfNotesSelected--;
    isSelectingSink.add(true);
  }

  ///
  /// handle the toggle of a note
  /// 
  void handleNoteToggle(Note note) {
    switch (note.isSelected) {
      case true:
        note.isSelected = false;
        break;
      case false:
        note.isSelected = true;
        break;
    }
  }
}