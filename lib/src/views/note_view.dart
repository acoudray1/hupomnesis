import 'package:flutter/material.dart';
import 'package:hupomnesis/src/bloc/note_bloc.dart';
import 'package:hupomnesis/src/model/enum_status.dart';
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
        noteBloc.pinnedNotes.isEmpty ? Container() : Expanded(
          child: ListView.builder(
            itemBuilder: _buildPinnedCard,
            itemCount: noteBloc.pinnedNotes.length,
          ),
        ),

        noteBloc.normalNotes.isEmpty ? Container() : Expanded(
          child: ListView.builder(
            itemBuilder: _buildNormalCard,
            itemCount: noteBloc.normalNotes.length,
          ),
        ),

        noteBloc.archivedNotes.isEmpty ? Container() : Expanded(
          child: ListView.builder(
            itemBuilder: _buildArchivedCard,
            itemCount: noteBloc.archivedNotes.length,
          ),
        ),
      ],
    );
  }

  // TODO: Refactor code for _buildCar method
  /// Pinned note card builder
  Widget _buildPinnedCard(BuildContext context, int index) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        child: Container(
          color: Colors.yellow,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.portrait),
                    onPressed: () {
                      // TODO: Send to note creation page
                      noteBloc.statusNormal(noteBloc.pinnedNotes[index]);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.restaurant),
                    onPressed: () {
                      // TODO: Implement settigs configuration
                      noteBloc.statusArchived(noteBloc.pinnedNotes[index]);
                    },
                  )
                ],
              ),
              Center(child: Text(noteBloc.pinnedNotes[index].name)),
              const SizedBox(height: 2.0,),
              Center(child: Text(noteBloc.pinnedNotes[index].text)),
              const SizedBox(height: 2.0,),
              Center(child: Text('${noteBloc.pinnedNotes[index].status}')),
            ],
          ),
        ),
      ),
    );
  }

  /// Pinned note card builder
  Widget _buildNormalCard(BuildContext context, int index) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        child: Container(
          color: Colors.yellow,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.pin_drop),
                    onPressed: () {
                      // TODO: Send to note creation page
                      noteBloc.statusPinned(noteBloc.normalNotes[index]);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.restaurant),
                    onPressed: () {
                      // TODO: Implement settigs configuration
                      noteBloc.statusArchived(noteBloc.normalNotes[index]);
                    },
                  )
                ],
              ),
              Center(child: Text(noteBloc.normalNotes[index].name)),
              const SizedBox(height: 2.0,),
              Center(child: Text(noteBloc.normalNotes[index].text)),
              const SizedBox(height: 2.0,),
              Center(child: Text('${noteBloc.normalNotes[index].status}')),
            ],
          ),
        ),
      ),
    );
  }

  /// Pinned note card builder
  Widget _buildArchivedCard(BuildContext context, int index) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        child: Container(
          color: Colors.yellow,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.portrait),
                    onPressed: () {
                      // TODO: Send to note creation page
                      noteBloc.statusNormal(noteBloc.archivedNotes[index]);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.pin_drop),
                    onPressed: () {
                      // TODO: Implement settigs configuration
                      noteBloc.statusPinned(noteBloc.archivedNotes[index]);
                    },
                  )
                ],
              ),
              Center(child: Text(noteBloc.archivedNotes[index].name)),
              const SizedBox(height: 2.0,),
              Center(child: Text(noteBloc.archivedNotes[index].text)),
              const SizedBox(height: 2.0,),
              Center(child: Text('${noteBloc.archivedNotes[index].status}')),
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