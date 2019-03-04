import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Hupomnesis',
      home: MyHomePage(),
    ),
  );
  SystemChrome.setEnabledSystemUIOverlays(<SystemUiOverlay>[]);
}

class MyHomePage extends StatefulWidget {
 @override
 _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPreferences data;
  List<String> texts;
  List<String> names;

  @override
  void initState() {
    super.initState();
    getInstance();
  }

  Future<void> getInstance() async {
    data = await SharedPreferences.getInstance();
    names = data.getStringList('names') ?? <String>['', '', '', ''];
    texts = data.getStringList('texts') ?? <String>['', '', '', ''];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: <Widget>[
          Container(
            height: 450, 
            child: reminders(),
          ),
        ],
      ),
    );
  }

  Widget reminders() {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 38),
      itemBuilder: (BuildContext context, int index) => _itemBuilder(context, index),
      itemCount: 4,
      scrollDirection: Axis.horizontal,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        width: 300.0,
        child: Column(
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(names[index], style: const TextStyle(fontSize: 28, color: Colors.grey, fontFamily: 'Roboto-Bold'),),
                ),
                IconButton(icon: const Icon(Icons.create), color: Colors.blue, onPressed: (){
                  _showDialog(index);
                },),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 38, 12, 0),
              child: Text.rich(
                TextSpan(text: texts[index], style: const TextStyle(fontSize: 22, color: Colors.black, fontFamily: 'Roboto-Light'),),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(int index) {
    showDialog<SimpleDialog>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('What do you want to learn today ?', style: TextStyle(fontFamily: 'Roboto-Light'),),
          contentPadding: const EdgeInsets.all(12),
          backgroundColor: Colors.white,
          children: <Widget>[
            textField(index, 1, 22, 'reminder\'s name', ValueToChange.name),
            textField(index, 9, 380, 'what should you remind ?', ValueToChange.text),
          ],
        );
      },
    );
  }

  Widget textField(int index, int maxLines, int maxLength, String text, ValueToChange vtc) {
    String val;
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            hintText: text,
          ),
          maxLines: maxLines,
          maxLength: maxLength,
          onSubmitted: (String value) => val = value,
        ),
        RaisedButton(
          color: Colors.blue,
          child: const Text('Submit!', style: TextStyle(fontFamily: 'Roboto-Light'),),
          onPressed: () => updateData(index, val, vtc)
        )
      ],
    );
  }

  void updateData(int index, String value, ValueToChange vtc) {
    setState(() {
      if(vtc == ValueToChange.text) {
        texts[index] = value;
        data.setStringList('texts', texts);
      } else {
        names[index] = value;
        data.setStringList('names', names);
      }
    });
  }
}

enum ValueToChange{ text, name, }