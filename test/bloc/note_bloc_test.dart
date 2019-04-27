import 'package:hupomnesis/src/bloc/note_bloc.dart';
import 'package:hupomnesis/src/model/note.dart';
import 'package:hupomnesis/src/resources/repository.dart';
import 'package:test/test.dart';

void main() {
  test('NoteBloc.createNote() creates a note, add it to Note.class and write it in json', () {
    final Repository repository = Repository();
    final NoteBloc noteBloc = NoteBloc();
    const String name = 'NOTE_TEST';
    const String text = 'This note is created for a test';

    noteBloc.createNote(name, text);
    repository.


    expect(noteBloc.notes, contains(Note(name: name, text: text)));


  });
}