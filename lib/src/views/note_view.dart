import 'package:flutter/material.dart';
import 'package:hupomnesis/src/bloc/note_bloc.dart';
import 'package:hupomnesis/src/model/note.dart';

class NoteView extends StatelessWidget {
  final NoteBloc noteBloc = NoteBloc();

  

  @override
  Widget build(BuildContext context) {
    noteBloc.bfetchNotesFromJson();

    return Scaffold(
      body: StreamBuilder<List<Note>>(
        stream: noteBloc.notesStream,
        initialData: noteBloc.notes,
        builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
          if (snapshot.hasData) {
            noteBloc.notes = snapshot.data;
            return noteBloc.notes.isNotEmpty ? listOfNotes(context) : emptyListOfNotes(context);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  /// List of Notes builder
  Widget listOfNotes(BuildContext context) {

    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemBuilder: _buildCard,
            itemCount: noteBloc.notes.length,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                noteBloc.createNote('NOTE #TEST', 'Lorem ipsum tititi');
              },
            ),
            FloatingActionButton(
              child: const Icon(Icons.remove),
              onPressed: () {
                noteBloc.deleteNote(noteBloc.notes.last);
              },
            ),
          ],
        ),
      ],
    );
  }

  /// Note card builder
  Widget _buildCard(BuildContext context, int index) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        child: Container(
          color: Colors.yellow,
          child: Column(
            children: <Widget>[
              Center(child: Text(noteBloc.notes[index].name)),
              const SizedBox(height: 2.0,),
              Center(child: Text(noteBloc.notes[index].text)),
            ],
          ),
        ),
      ),
    );
  }

  /// List of Notes to display if there is no notes
  Widget emptyListOfNotes(BuildContext context) {

    return Column(
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height * 0.45),
        Center(child: const Text('There was no data in the file')),
        FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            noteBloc.createNote('NOTE #TEST', 'Lorem ipsum tititi');
          },
        ),
      ],
    );
  }
}