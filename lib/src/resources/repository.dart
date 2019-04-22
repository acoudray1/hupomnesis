import 'dart:io';
import 'package:hupomnesis/config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hupomnesis/src/model/note.dart';
import 'package:hupomnesis/src/resources/note_manager.dart';

/// 
/// This class is the entry point of our management classes
/// 
class Repository {

  Repository();

  final NoteManager noteManager = NoteManager();

  // Method used to fetch notes from a json file
  Future<List<Note>> fetchAllNotes() => noteManager.fetchNotes('assets/notes.json');

  // Method that allows us to get the Document path where documents are stored
  Future<String> get _localPath async {
    final dynamic directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  // Create the reference to the file we want to create
  Future<File> _localFile(String name) async {
    final String path = await _localPath;

    return File('$path/$name');
  }

  Future<File> writeCounter(int counter) async {
    final File file = await _localFile(properties['NOTES_FILE_NAME']);

    // Write the file
    return file.writeAsString('$counter');
  }
}
