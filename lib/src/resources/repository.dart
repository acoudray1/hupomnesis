import 'dart:io';
import 'package:hupomnesis/config.dart';
import 'package:hupomnesis/src/model/note.dart';
import 'package:hupomnesis/src/resources/note_manager.dart';
import 'package:path_provider/path_provider.dart';

/// 
/// This class is the entry point of our management classes
/// 
class Repository {

  Repository();

  final NoteManager noteManager = NoteManager();

  // Method used to fetch notes from a json file
  Future<List<Note>> fetchAllNotes() async {
    final String str = await fetchFile('${properties['NOTES_FILE_NAME']}');
    
    return noteManager.noteFromJson(str);
  }

  // Method used to write a list of notes in a file
  Future<void> writeAllNotes(List<Note> notes) async {
    final String str = noteManager.noteToJson(notes);

    writeData(str, properties['NOTES_FILE_NAME']);
  }  

  // Method that allows us to get the Document path where documents are stored
  Future<String> get _localPath async {
    final dynamic directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  // Create the reference to the file we want to create
  Future<File> _localFile(String fileName) async {
    final String path = await _localPath;

    return File('$path/$fileName');
  }

  // Fetch data as a String from a file (if no data is here, create a new empty file)
  Future<String> fetchFile(String fileName) async {
    final File file = await _localFile(fileName);
    String response;

    if (file.existsSync()) {
      response = await file.readAsString();
    } else {
      writeData('[\n]', fileName);
      response = await file.readAsString();
    }

    print(response);
    return response;
  }

  // Write data in a created File
  Future<File> writeData(String data, String fileName) async {
    final File file = await _localFile(fileName);

    return file.writeAsString('$data');
  }

  // Read data and return a String
  Future<String> readData(String fileName) async {
    final File file = await _localFile(fileName);

    return file.readAsString();
  }
}
