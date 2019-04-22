import 'package:flutter/material.dart';
import 'package:hupomnesis/src/bloc/note_bloc.dart';
import 'package:hupomnesis/src/model/note.dart';

class NoteView extends StatelessWidget {
  final NoteBloc noteBloc = NoteBloc();

  List<Note> notes = <Note>[];

  @override
  Widget build(BuildContext context) {
    noteBloc.bfetchNotesFromJson();

    return Scaffold(
      body: StreamBuilder<List<Note>>(
        stream: noteBloc.notesStream,
        initialData: notes,
        builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
          if (snapshot.hasData) {
            notes = snapshot.data;
            return notes.isNotEmpty ? listOfNotes(context) : emptyListOfNotes(context);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  /// List of Notes builder
  Widget listOfNotes(BuildContext context) {

    return ListView.builder(
      itemBuilder: _buildCard,
      itemCount: notes.length,
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
              Center(child: Text(notes[index].name)),
              const SizedBox(height: 2.0,),
              Center(child: Text(notes[index].text)),
            ],
          )
        ),
      ),
    );
  }

  /// List of Notes to display if there is no notes
  Widget emptyListOfNotes(BuildContext context) {

    return Center(
      child: const Text('There was no data in the file'),
    );
  }
}