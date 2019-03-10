import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:flare_flutter/flare_actor.dart';

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
  bool introduction;
  List<String> names;
  List<String> texts;

  @override
  void initState() {
    super.initState();
    getInstance();
    flutterLocalNotificationsPlugin.initialize(const InitializationSettings(AndroidInitializationSettings('app_icon'), null));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
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
    _repeatNotification();
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
        textField(index, 1, names[index], ValueToChange.name, TextAlign.start, 'Title'),
        textField(index, 15, texts[index], ValueToChange.text, TextAlign.justify, 'Note'),
      ],
    );
  }

  Widget _buildIndex() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.95),
      child: PageViewIndicator(
        pageIndexNotifier: pageIndexNotifier,
        length: 4,
        normalBuilder: (AnimationController animationController) => Circle(
          size: 8.0,
          color: Colors.black54,
        ),
        highlightedBuilder: (AnimationController animationController) => ScaleTransition(
          scale: CurvedAnimation(
            parent: animationController,
            curve: Curves.ease,
          ),
          child: Circle(
            size: 11.0,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget textField(int index, int maxLines, String text, ValueToChange vtc, TextAlign textAlign, String hint) {
    final TextEditingController controller = TextEditingController();
    controller.text = text;
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 24, 5, 12),
      child: TextField(
        decoration: InputDecoration.collapsed(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 28, color: Colors.black54, fontFamily: 'Roboto-Light'),
        ),
        controller: controller,
        textAlign: textAlign,
        style: const TextStyle(fontSize: 28, color: Colors.black, fontFamily: 'Roboto-Light'),
        maxLines: maxLines,
        textInputAction: TextInputAction.done,
        onSubmitted: (String value) => updateData(index, vtc, value),
      ),
    );
  }

  Future<void> getInstance() async {
    data = await SharedPreferences.getInstance();
    setState(() {
      names = data.getStringList('names') ?? <String>['', '', '', ''];
      texts = data.getStringList('texts') ?? <String>['', '', '', ''];
      introduction = data.getBool('introduction') ?? false;
    });
  }

  void updateData(int index, ValueToChange vtc, String value) {
    setState(() {
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
    final int rnd = Random().nextInt(4);
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeating channel id',
      'repeating channel name',
      'repeating description');
    final NotificationDetails platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.periodicallyShow(0, '${names[rnd]}','${texts[rnd]}', RepeatInterval.EveryMinute, platformChannelSpecifics);
  }
}

enum ValueToChange{ text, name, }