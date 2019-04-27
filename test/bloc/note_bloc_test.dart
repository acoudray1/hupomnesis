import 'package:hupomnesis/config.dart';
import 'package:hupomnesis/src/bloc/note_bloc.dart';
import 'package:hupomnesis/src/model/note.dart';
import 'package:hupomnesis/src/resources/note_manager.dart';
import 'package:hupomnesis/src/resources/repository.dart';
import 'package:test/test.dart';

void main() {
  test('NoteBloc.createNote() creates a note, add it to Note.class and write it in json', () async {
    final Repository repository = Repository();
    final NoteBloc noteBloc = NoteBloc();
    final NoteManager noteManager = NoteManager();
    const String name = 'NOTE_TEST';
    const String text = 'This note is created for a test';
    String writtenData;

    noteBloc.createNote(name, text);
    writtenData = await repository.readData(properties['NOTES_FILE_NAME']);

    expect(noteBloc.notes, contains(Note(name: name, text: text)));
    expect(noteBloc.notes, equals(noteManager.noteFromJson(writtenData)));
  });
}
