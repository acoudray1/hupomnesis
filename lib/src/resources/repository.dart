import 'package:hupomnesis/src/model/note.dart';
import 'package:hupomnesis/src/resources/note_manager.dart';

/// 
/// This class is the entry point of our management classes
/// 
class Repository {

  final NoteManager noteManager = NoteManager();

  // Method used to fetch notes from a json file
  Future<List<Note>> fetchAllNotes() => noteManager.fetchNotes('assets/notes.json');
}