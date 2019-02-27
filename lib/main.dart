import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
    runApp(
    MaterialApp(
      title: 'Hupomnesis',
      home: Reminder(),
    ),
  );
  SystemChrome.setEnabledSystemUIOverlays(<SystemUiOverlay>[]);
}

class Reminder extends StatefulWidget {
  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  bool _editing; 
  //FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future<Note> noteFromJson(String path) async {
    final String response = await rootBundle.loadString(path);
    final dynamic jsonData = json.decode(response);
    return Note.fromJson(jsonData);
  }

  Future<String> noteToJson(Note data, String localPath) async {
    final File temp = await file.localFile(localPath);
    final dynamic dyn = data.toJson();
    return json.encode(dyn);
    return temp.writeAsString(data);
  }

  @override
  void initState() {
    super.initState();
    _editing = false; 
    /*_firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) {
          print('on message $message');
        }
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Column(
        children: <Widget> [
          welcomingText(),    // The message that will be displayed for the person
          //noteWidget(),       // The list of notes
        ],
      ),
    );
  }

  Widget welcomingText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget> [
        Text('Hi there,', style: TextStyle(fontSize: 30.0, color: Colors.white),),
        Text('What did you learn ?', style: TextStyle(color: Colors.white),),
        // Text("You have 3 tasks to do today.", style: TextStyle(color: Colors.white,),),
      ],
    );
  }

  Widget noteWidget() {
    return _buildList(context, dummySnapshot);
  }

Widget _buildList(BuildContext context, List<Map<String, dynamic>> snapshot) {

  return ListView.builder(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.only(top: 20.0),
    itemBuilder: ,
  );
}

  Widget _buildListItem(BuildContext context, Map<String, dynamic> data) {
    final dynamic note = Note.fromMap(data);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      /*child: GestureDetector(
        onTap: () {
          setState(() { _editing = true; });
        },*/
        /*child: Container(
          width: 250,
          child: Column(
            children: <Widget>[
              Text('${note.name}', style: const TextStyle(fontSize: 30.0, color: Colors.black),),
              _editing ? TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 9,
                onSubmitted: (String value) {
                  setState(() { 
                    _editing = false;
                    note.reference.updateData(<String, dynamic> {'text': value});
                  });
                }
              ) : Text('${note.text}', style: const TextStyle(fontSize: 18.0, color: Colors.black),)
            ],
          ),
        ),*/
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: ListTile(
            title: Text(note.name),
            trailing: Text(note.text),
          ),
        ),
      //),
    );
  }
}

class Note {
  Note({
      this.name,
      this.text,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
      name: json['name'],
      text: json['text'],
  );

  String name;
  String text;

  Map<String, dynamic> toJson() => <String, dynamic> {
    'name': name,
    'text': text,
  };
}