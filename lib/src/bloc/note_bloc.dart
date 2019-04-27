import 'dart:async';
import 'package:hupomnesis/src/model/note.dart';
import 'package:hupomnesis/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class NoteBloc {
  
  Repository repository = Repository();

  List<Note> notes = <Note>[];

  final BehaviorSubject<List<Note>> _notesFetcher = BehaviorSubject<List<Note>>();

  Observable<List<Note>> get notesStream => _notesFetcher.stream;

  StreamSink<List<Note>> get notesSink => _notesFetcher.sink;

  // Fetch notes from json and then add them to the StreamBuilder sink
  Future<void> bfetchNotesFromJson() async {
    final List<Note> snapshot = await repository.fetchAllNotes();

    notesSink.add(snapshot);
  }

  // Writes note from a String in a file and fetch the notes to display after
  Future<void> bwriteNoteToJson(List<Note> data) async {
    await repository.writeAllNotes(data);

    bfetchNotesFromJson();
  }

  // Create a note
  void createNote(String name, String text) {
    final Note noteToCreate = Note(name: name, text: text);

    notes.add(noteToCreate);

    bwriteNoteToJson(notes);
  }

  // dispose the different controllers used
  void dispose() {
    _notesFetcher.close();
  }
}