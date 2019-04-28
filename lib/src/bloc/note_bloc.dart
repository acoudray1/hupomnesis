import 'dart:async';
import 'package:hupomnesis/src/model/enum_status.dart';
import 'package:hupomnesis/src/model/note.dart';
import 'package:hupomnesis/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class NoteBloc {
  
  Repository repository = Repository();

  List<Note> notes = <Note>[];
  List<Note> normalNotes = <Note>[];
  List<Note> archivedNotes = <Note>[];
  List<Note> pinnedNotes = <Note>[];

  final BehaviorSubject<List<Note>> _notesFetcher = BehaviorSubject<List<Note>>();

  Observable<List<Note>> get notesStream => _notesFetcher.stream;

  StreamSink<List<Note>> get notesSink => _notesFetcher.sink;

  // Fetch notes from json and then add them to the StreamBuilder sink
  // Dispatch notes in three list of notes depending on their status
  Future<void> bfetchNotesFromJson() async {
    final List<Note> snapshot = await repository.fetchAllNotes();

    normalNotes.clear();
    archivedNotes.clear();
    pinnedNotes.clear();

    for (Note note in snapshot) {
      switch (note.status) {
        case Status.NORMAL:
          normalNotes.add(note);
          break;
        case Status.ARCHIVED:
          archivedNotes.add(note);
          break;
        case Status.PINNED:
          pinnedNotes.add(note);
          break;
      }
    }

    notes = snapshot;

    notesSink.add(snapshot);
  }

  // Writes note from a String in a file and fetch the notes to display after
  Future<void> bwriteNoteToJson(List<Note> data) async {
    await repository.writeAllNotes(data);

    bfetchNotesFromJson();
  }

  // Create a note
  void createNote(String name, String text) {
    final Note noteToCreate = Note(name: name, text: text, status: Status.NORMAL);

    notes.add(noteToCreate);

    bwriteNoteToJson(notes);
  }

  // Delete a note
  void deleteNote(Note note) {
    notes.remove(note);

    bwriteNoteToJson(notes);
  }

  // Change status to archived
  void statusArchived(Note note) {
    note.status = Status.ARCHIVED;

    bwriteNoteToJson(notes);
  }

  // Change status to pinned
  void statusPinned(Note note) {
    note.status = Status.PINNED;

    bwriteNoteToJson(notes);
  }

  // Change status to normal
  void statusNormal(Note note) {
    note.status = Status.NORMAL;

    bwriteNoteToJson(notes);
  }

  // dispose the different controllers used
  void dispose() {
    _notesFetcher.close();
  }
}