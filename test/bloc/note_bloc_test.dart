import 'package:hupomnesis/src/bloc/note_bloc/note_bloc.dart';
import 'package:test/test.dart';
import 'package:hupomnesis/src/model/note.dart';

void main() {
  test('NoteBloc.createNote() creates a note, add it to Note.class and write it in json', () async {
    // final Repository repository = Repository();
    final NoteBloc noteBloc = NoteBloc();
    // final NoteManager noteManager = NoteManager();
    const String text = 'This note is created for a test';
    //String writtenData;

    noteBloc.createNote(text);
    // writtenData = await repository.readData(properties['NOTES_FILE_NAME']);

    expect(noteBloc.notes, contains(Note(text: text)));
    // expect(noteBloc.notes, equals(noteManager.noteFromJson(writtenData)));
  });
}
