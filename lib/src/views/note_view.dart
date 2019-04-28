import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hupomnesis/src/bloc/note_bloc.dart';
import 'package:hupomnesis/src/model/note.dart';

class NoteView extends StatelessWidget {
  final NoteBloc noteBloc = NoteBloc();

  @override
  Widget build(BuildContext context) {
    noteBloc.bfetchNotesFromJson();

    return Scaffold(
      body: Column(
        children: <Widget>[ 
          // Builds the header
          buildHeader(context),
          // Builds the list of notes
          Expanded(
            child: StreamBuilder<List<Note>>(
              stream: noteBloc.notesStream,
              initialData: noteBloc.notes,
              builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
                if (snapshot.hasData) {
                  return noteBloc.notes.isNotEmpty ? listOfNotes(context) : emptyListOfNotes(context);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          
        ],
      ),
    );
  }

  /// Header builder
  Widget buildHeader(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.blue,
          height: 24.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // TODO: Send to note creation page
                noteBloc.createNote('NOTE #TEST', 'Lorem ipsum tititi');
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // TODO: Implement settigs configuration
                print('settings');
                noteBloc.deleteNote(noteBloc.notes.last);
              },
            )
          ],
        ),
      ],
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