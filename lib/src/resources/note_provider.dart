import 'dart:io';
import 'package:hupomnesis/src/model/note.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NoteProvider {

  NoteProvider._privateConstructor();

  Database _database;

  static const String _databaseName = 'note_db';
  static const int _databaseVersion = 102019;

  static final NoteProvider instance = NoteProvider._privateConstructor();

  ///
  /// Returns the instance of the database we need
  /// 
  Future<Database> get database async {
    if (_database != null) 
      return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  ///
  /// This opens the database (and creates it if it doesn't exist)
  ///
  Future<dynamic> _initDatabase() async {
    final Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  ///
  /// Creates the table for notes in database
  ///
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''
        CREATE TABLE $tableNote (
          $columnId INTEGER PRIMARY KEY,
          $columnText TEXT,
          $columnColorSelected TEXT NOT NULL,
          $columnStatus TEXT NOT NULL
        )
      '''
    );
  }

  ///
  /// Insert a new note in the note's table
  ///
  Future<int> insertNewNote(Note note) async {
    final Map<String, dynamic> row = note.toMap();
    final Database db = await instance.database;
    return await db.insert(tableNote, row);
  }

  ///
  /// Query the notes and create a list of notes
  /// 
  Future<List<Note>> notesFromDatabase() async {
    final List<Map<String, dynamic>> noteMaps = await _queryAllRows();
    final List<Note> notes = <Note>[];

    for(Map<String, dynamic> map in noteMaps){
      print(map);
      notes.add(Note.fromMap(map));
    }

    return notes;
  }

  ///
  /// Query all rows from the database as a list of maps, where each maps
  /// is a key - value list of columns
  /// 
  Future<List<Map<String, dynamic>>> _queryAllRows() async {
    final Database db = await instance.database;
    return await db.query(tableNote);
  }

  ///
  /// Returns the row count
  /// 
  Future<int> queryRowCount() async {
    final Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tableNote'));
  }

  /// 
  /// Updates a note in the database
  /// 
  Future<int> updateNote(Note note) async {
    final Database db = await instance.database;
    final Map<String, dynamic> row = note.toMap();
    final int id = row[columnId];
    return await db.update(tableNote, row, where: '$columnId = ?', whereArgs: <int>[id]);
  }

  ///
  /// Deletes a note in the database
  /// 
  Future<int> deleteNote(Note note) async {
    final Database db = await instance.database;
    return await db.delete(tableNote, where: '$columnId = ?', whereArgs: <int>[note.id]);
  }
}