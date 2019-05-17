import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hupomnesis/src/bloc/note_bloc/note_selection_bloc.dart';
import 'package:hupomnesis/src/model/enum_color_selected.dart';
import 'package:hupomnesis/src/model/enum_status.dart';
import 'package:hupomnesis/src/model/note.dart';
import 'package:hupomnesis/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

///
/// Business Logic class to manage notes
/// 
class NoteBloc {
  
  final Repository repository = Repository();

  List<Note> notes = <Note>[];
  List<Note> normalNotes = <Note>[];
  List<Note> archivedNotes = <Note>[];
  List<Note> pinnedNotes = <Note>[];

  final BehaviorSubject<List<Note>> _notesFetcher = BehaviorSubject<List<Note>>();
  Observable<List<Note>> get notesStream => _notesFetcher.stream;
  StreamSink<List<Note>> get notesSink => _notesFetcher.sink;

  ///
  /// Fetch notes from json and then add them to the StreamBuilder sink
  /// Dispatch notes in three list of notes depending on their status
  /// 
  Future<void> bfetchNotesFromJson() async {
    final List<Note> snapshot = await repository.fetchAllNotes();

    normalNotes.clear();
    archivedNotes.clear();
    pinnedNotes.clear();

    for (Note n in snapshot) {
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
    
    notes = snapshot;

    notesSink.add(snapshot);
  }

  ///
  /// Writes note from a String in a file and fetch the notes to display after
  /// 
  Future<void> bwriteNoteToJson(List<Note> data) async {
    await repository.writeAllNotes(data).then((_) => bfetchNotesFromJson());
  }

  ///
  /// Create a note
  /// 
  void createNote(String name, String text) {
    final Note noteToCreate = Note(name: name, text: text, status: Status.NORMAL, colorSelected: ColorSelected.NORMAL);

    notes.add(noteToCreate);

    bwriteNoteToJson(notes);
  }

  ///
  /// Change the note color of selected notes
  /// 
  void changeColor({Note note, List<Note> listOfNotes, NoteSelectionBloc noteSelectionBloc, @required ColorSelected colorSelected}) {
    assert ((note != null && listOfNotes == null) || (note == null && listOfNotes != null));

    if(note != null) {
      if(note.isSelected) {
        note.colorSelected == colorSelected ? note.colorSelected = ColorSelected.NORMAL : note.colorSelected = colorSelected;
      }
    } else if(listOfNotes != null) {
      for(Note n in listOfNotes) {
        if(n.isSelected) {
          n.colorSelected == colorSelected ? n.colorSelected = ColorSelected.NORMAL : n.colorSelected = colorSelected;
        }
      }
    }

    if (noteSelectionBloc != null) 
      noteSelectionBloc.handleCompleteDiscard(notes);

    bwriteNoteToJson(notes);
  }

  ///
  /// Delete a note
  /// 
  void deleteNote({Note note, List<Note> listOfNotes, NoteSelectionBloc noteSelectionBloc}) {
    assert (note != null && listOfNotes == null || note == null && listOfNotes != null);

    final List<Note> newList = <Note>[];

    if(note != null) {
      if(note.isSelected == false)
        newList.add(note);
    } else if(listOfNotes != null) {
      for(Note n in listOfNotes) {
        if(n.isSelected == false) {
          newList.add(n);
        }
      }
    }
    
    if (noteSelectionBloc != null) 
      noteSelectionBloc.handleCompleteDiscard(notes);

    bwriteNoteToJson(newList);
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
        }
      }
    }

    if (noteSelectionBloc != null) 
      noteSelectionBloc.handleCompleteDiscard(notes);

    bwriteNoteToJson(notes);
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
        }
      }
    }

    if (noteSelectionBloc != null) 
      noteSelectionBloc.handleCompleteDiscard(notes);

    bwriteNoteToJson(notes);
  }

  ///
  /// dispose the different controllers used
  /// 
  void dispose() {
    _notesFetcher.close();
  }
}