import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hupomnesis/src/bloc/note_bloc/note_selection_bloc.dart';
import 'package:hupomnesis/src/model/enum_color_selected.dart';
import 'package:hupomnesis/src/model/enum_status.dart';
import 'package:hupomnesis/src/model/note.dart';
import 'package:hupomnesis/src/resources/note_provider.dart';
import 'package:rxdart/rxdart.dart';

///
/// Business Logic class to manage notes
/// 
class NoteBloc {

  List<Note> notes = <Note>[];
  List<Note> normalNotes = <Note>[];
  List<Note> archivedNotes = <Note>[];
  List<Note> pinnedNotes = <Note>[];

  final BehaviorSubject<List<Note>> _notesFetcher = BehaviorSubject<List<Note>>();
  Observable<List<Note>> get notesStream => _notesFetcher.stream;
  StreamSink<List<Note>> get notesSink => _notesFetcher.sink;

  ///
  /// Get notes from the database and then add them to the StreamBuilder sink
  /// Dispatch notes in three list of notes depending on their status
  /// 
  Future<void> getNotesFromDatabase() async {

    final List<Note> data = await NoteProvider.instance.notesFromDatabase();

    normalNotes.clear();
    archivedNotes.clear();
    pinnedNotes.clear();

    for (Note n in data) {
      switch (n.status) {
        case Status.NORMAL:
          normalNotes.add(n);
          break;
        case Status.ARCHIVED:
          archivedNotes.add(n);
          break;
        case Status.PINNED:
          pinnedNotes.add(n);
          break;
      }
    }
    
    notes = data;

    notesSink.add(data);
  }

  ///
  /// Update a note in the database
  ///
  Future<void> _updateNote(Note note) async => NoteProvider.instance.updateNote(note);

  ///
  /// Delete a note in the database
  /// 
  Future<void> _deleteNote(Note note) async => NoteProvider.instance.deleteNote(note);

  ///
  /// Insert new note in database
  /// 
  Future<void> _insertNote(Note note) async => NoteProvider.instance.insertNewNote(note);

  ///
  /// Create a note
  /// 
  void createNote(String text) {
    
    final Note noteToCreate = Note(text: text, status: Status.NORMAL, colorSelected: ColorSelected.NORMAL);

    notes.add(noteToCreate);

    _insertNote(noteToCreate);

    notesSink.add(notes);
  }

  ///
  /// Change the note color of selected notes
  /// 
  void changeColor({Note note, List<Note> listOfNotes, NoteSelectionBloc noteSelectionBloc, @required ColorSelected colorSelected}) {
    assert ((note != null && listOfNotes == null) || (note == null && listOfNotes != null));

    if(note != null) {
      if(note.isSelected) {
        note.colorSelected == colorSelected ? note.colorSelected = ColorSelected.NORMAL : note.colorSelected = colorSelected;
        _updateNote(note);
      }
    } else if(listOfNotes != null) {
      for(Note n in listOfNotes) {
        if(n.isSelected) {
          n.colorSelected == colorSelected ? n.colorSelected = ColorSelected.NORMAL : n.colorSelected = colorSelected;
          _updateNote(n);
        }
      }
    }

    if (noteSelectionBloc != null) 
      noteSelectionBloc.handleCompleteDiscard(notes);

    getNotesFromDatabase();
  }

  ///
  /// Delete a note
  /// 
  void deleteNote({Note note, List<Note> listOfNotes, NoteSelectionBloc noteSelectionBloc}) {
    assert (note != null && listOfNotes == null || note == null && listOfNotes != null);

    if(note != null) {
      if(note.isSelected)
        _deleteNote(note);
    } else if(listOfNotes != null) {
      for(Note n in listOfNotes) {
        if(n.isSelected) {
          _deleteNote(n);
        }
      }
    }
    
    if (noteSelectionBloc != null) 
      noteSelectionBloc.handleCompleteDiscard(notes);

    getNotesFromDatabase();
  }

  ///
  /// Change status to archived
  /// 
  void noteToArchived({Note note, List<Note> listOfNotes, NoteSelectionBloc noteSelectionBloc}) {
    assert (note != null && listOfNotes == null || note == null && listOfNotes != null);

    if(note != null) {
      if(note.isSelected) {
        switch (note.status) {
          case Status.PINNED:
            note.status = Status.ARCHIVED;
            break;
          case Status.NORMAL:
            note.status = Status.ARCHIVED;
            break;
          case Status.ARCHIVED:
            note.status = Status.NORMAL;
            break;
          default:
            note.status = Status.ARCHIVED;
            break;
        }
        _updateNote(note);
      }
    } else if(listOfNotes != null) {
      for(Note n in listOfNotes) {
        if(n.isSelected) {
          switch (n.status) {
            case Status.PINNED:
              n.status = Status.ARCHIVED;
              break;
            case Status.NORMAL:
              n.status = Status.ARCHIVED;
              break;
            case Status.ARCHIVED:
              n.status = Status.NORMAL;
              break;
            default:
              n.status = Status.ARCHIVED;
              break;
          }
          _updateNote(n);
        }
      }
    }

    if (noteSelectionBloc != null) 
      noteSelectionBloc.handleCompleteDiscard(notes);

    getNotesFromDatabase();
  }

  ///
  /// Change status to pinned
  /// 
  void noteToPinned({Note note, List<Note> listOfNotes, NoteSelectionBloc noteSelectionBloc}) {
    assert (note != null && listOfNotes == null || note == null && listOfNotes != null);

    if(note != null) {
      if(note.isSelected) {
        switch (note.status) {
          case Status.PINNED:
            note.status = Status.NORMAL;
            break;
          case Status.NORMAL:
            note.status = Status.PINNED;
            break;
          case Status.ARCHIVED:
            note.status = Status.PINNED;
            break;
          default:
            note.status = Status.PINNED;
            break;
        }
        _updateNote(note);
      }
    } else if(listOfNotes != null) {
      for(Note n in listOfNotes) {
        if(n.isSelected) {
          switch (n.status) {
            case Status.PINNED:
              n.status = Status.NORMAL;
              break;
            case Status.NORMAL:
              n.status = Status.PINNED;
              break;
            case Status.ARCHIVED:
              n.status = Status.PINNED;
              break;
            default:
              n.status = Status.PINNED;
              break;
          }
          _updateNote(n);
        }
      }
    }

    if (noteSelectionBloc != null) 
      noteSelectionBloc.handleCompleteDiscard(notes);

    getNotesFromDatabase();
  }

  ///
  /// Update a note
  ///
  Future<void> updateNote(Note note) async {

    _updateNote(note);

    notesSink.add(notes);
  }

  ///
  /// dispose the different controllers used
  /// 
  void dispose() {
    _notesFetcher.close();
  }
}