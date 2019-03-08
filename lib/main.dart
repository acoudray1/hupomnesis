import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

void main() {
  runApp(MaterialApp(
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
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final ValueNotifier<int> pageIndexNotifier = ValueNotifier<int>(0);
  bool _editing = false;
  List<String> names;
  List<String> texts;

  @override
  void initState() {
    super.initState();
    getInstance();
    flutterLocalNotificationsPlugin.initialize(const InitializationSettings(AndroidInitializationSettings('app_icon'), null));
    _repeatNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: names == null 
      ? const CircularProgressIndicator() 
      : Stack(
        children: <Widget>[
          reminders(),
          _buildIndex(),
        ],
      ),
    );
  }

  Widget reminders() {
    return PageView.builder(
      onPageChanged: (int index) => pageIndexNotifier.value = index,
      itemBuilder: (BuildContext context, int index) => _itemBuilder(context, index),
      itemCount: 4,
      scrollDirection: Axis.horizontal,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              _editing = true;
            });
          },
          child: _editing 
            ? textField(index, 1, 13, 'reminder\'s name', ValueToChange.name)
            : Text(names[index], style: const TextStyle(fontSize: 28, color: Colors.grey, fontFamily: 'Roboto-Bold'),),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _editing = true;
            });
          },
          child: _editing 
            ? textField(index, 9, 380, 'what should you remind ?', ValueToChange.text)
            : Text(names[index], style: const TextStyle(fontSize: 28, color: Colors.grey, fontFamily: 'Roboto-Bold'),),
        )
      ],
    );
  }

  Widget _buildIndex() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.9),
      child: PageViewIndicator(
      pageIndexNotifier: pageIndexNotifier,
      length: 4,
      normalBuilder: (AnimationController animationController) => Circle(
            size: 8.0,
            color: Colors.black87,
          ),
      highlightedBuilder: (AnimationController animationController) => ScaleTransition(
            scale: CurvedAnimation(
              parent: animationController,
              curve: Curves.ease,
            ),
            child: Circle(
              size: 12.0,
              color: Colors.black,
            ),
          ),
    ),
    );
  }

  Widget textField(int index, int maxLines, int maxLength, String text, ValueToChange vtc) {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            hintText: text,
          ),
          maxLines: maxLines,
          maxLength: maxLength,
          onSubmitted: (String value) => updateData(index, vtc, value),
        ),
      ],
    );
  }

  Future<void> getInstance() async {
    data = await SharedPreferences.getInstance();
    setState(() {
      names = data.getStringList('names') ?? <String>['a', 'c', 'f', 'g'];
      texts = data.getStringList('texts') ?? <String>['b', 'd', 'e', 'h'];
    });
  }

  void updateData(int index, ValueToChange vtc, String value) {
    setState(() {
      _editing = false;
      getInstance();
      if(vtc == ValueToChange.text) {
        texts[index] = value;
        data.setStringList('texts', texts);
      } else {
        names[index] = value.toUpperCase();
        data.setStringList('names', names);
      }
    });
  }

  Future<void> _repeatNotification() async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeating channel id',
      'repeating channel name',
      'repeating description');
    final NotificationDetails platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title','repeating body', RepeatInterval.EveryMinute, platformChannelSpecifics);
  }
}

enum ValueToChange{ text, name, }