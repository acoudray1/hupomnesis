import 'dart:async';

import 'package:hupomnesis/src/model/note.dart';
import 'package:rxdart/rxdart.dart';

class NoteSelectionBloc {

  final BehaviorSubject<bool> _isSelecting = BehaviorSubject<bool>();
  Observable<bool> get isSelectingStream => _isSelecting.stream;
  StreamSink<bool> get isSelectingSink => _isSelecting.sink;

  int numberOfNotesSelected = 0;

  ///
  /// handle the selection of a note of a note
  /// 
  void handleNoteToggle(Note note) {
    switch (note.isSelected) {
      case true:
        note.isSelected = false;
        _handleAllStates(note, Change.MINUS);
        break;
      case false:
        note.isSelected = true;
        _handleAllStates(note, Change.ADD);
        break;
    }
  }

  ///
  /// handle complete discard
  /// 
  void handleCompleteDiscard(List<Note> notes) {
    for (Note n in notes) {
      if(n.isSelected)
        n.isSelected = false;
    }
    numberOfNotesSelected = 0;
    isSelectingSink.add(false);
  }

  ///
  /// handle the stream controller instead of what we are doing
  /// 
  void _handleAllStates(Note note, Change change) {
    if(numberOfNotesSelected == 0) {
      switch (change) {
        case Change.ADD:
          numberOfNotesSelected++;
          isSelectingSink.add(true);
          break;
        case Change.MINUS:
          throw Exception('There is an error : there already is zero note selected');
          break;
      }
    } else if(numberOfNotesSelected == 1) {
      switch (change) {
        case Change.ADD:
          numberOfNotesSelected++;
          isSelectingSink.add(true);
          break;
        case Change.MINUS:
          numberOfNotesSelected--;
          isSelectingSink.add(false);
          break;
      }
    } else if(numberOfNotesSelected > 1) {
      switch (change) {
        case Change.ADD:
          numberOfNotesSelected++;
          isSelectingSink.add(true);
          break;
        case Change.MINUS:
          numberOfNotesSelected--;
          isSelectingSink.add(true);
          break;
      }
    } else {
      throw Exception('There is an error : note\'s selected number shouldn\'t be lower than zero');
    }
  }
}

enum Change {
  ADD, MINUS,
}