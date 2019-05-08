import 'dart:async';

import 'package:hupomnesis/src/bloc/note_bloc/note_bloc.dart';
import 'package:hupomnesis/src/model/enum_status.dart';
import 'package:hupomnesis/src/model/note.dart';
import 'package:rxdart/rxdart.dart';

class NoteSelectionBloc {

  final BehaviorSubject<bool> _isSelecting = BehaviorSubject<bool>();
  Observable<bool> get isSelectingStream => _isSelecting.stream;
  StreamSink<bool> get isSelectingSink => _isSelecting.sink;

  int numberOfNotesSelected = 0;

  ///
  /// handle the long press on a note 
  /// 
  void handleNoteSelection(Note note) {
    note.isSelected = true;
    _handleAllStates(note, Change.ADD);
  }

  ///
  /// handle the toggle of a note
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
    for (Note note in notes) {
      if(note.isSelected)
        note.isSelected = false;
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

  ///
  /// handle the note status to pinned
  /// 
  void noteToPinned(List<Note> notes, NoteBloc noteBloc) {
    final List<Note> notesToPin = <Note>[];
    final List<Note> notesToNormal = <Note>[];

    for (Note note in notes) {
      if(note.isSelected) {
        if(note.status != Status.PINNED) {
          notesToPin.add(note);
        } else if (note.status == Status.PINNED) {
          notesToNormal.add(note);
        }
      }
    }

    noteBloc.statusPinned(listOfNotes: notesToPin);
    noteBloc.statusNormal(listOfNotes: notesToNormal);
    handleCompleteDiscard(notes);
  }

  ///
  /// handle the note status to archived
  /// 
  void noteToArchived(List<Note> notes, NoteBloc noteBloc) {
    final List<Note> notesToArchive = <Note>[];
    final List<Note> notesToNormal = <Note>[];

    for (Note note in notes) {
      if(note.isSelected) {
        if(note.status != Status.ARCHIVED) {
          notesToArchive.add(note);
        } else if (note.status == Status.ARCHIVED) {
          notesToNormal.add(note);
        }
      }
    }
    
    noteBloc.statusArchived(listOfNotes: notesToArchive);
    noteBloc.statusNormal(listOfNotes: notesToNormal);
    handleCompleteDiscard(notes);
  }

  ///
  /// handle the note deleting
  /// 
  void noteDelete(List<Note> notes, NoteBloc noteBloc) {
    for (Note note in notes) {
      if(note.isSelected)
        noteBloc.deleteNote(note);
    }
    handleCompleteDiscard(notes);
  }
}

enum Change {
  ADD, MINUS,
}