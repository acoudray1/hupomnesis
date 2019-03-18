import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

void main() => runApp(MaterialApp(title: 'Hupomnesis', home: Home()));

class Home extends StatefulWidget {
 @override
 _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences data;
  FlutterLocalNotificationsPlugin localNotif = FlutterLocalNotificationsPlugin();
  final ValueNotifier<int> pIndex = ValueNotifier<int>(0);
  bool start;
  List<String> names, texts;
  bool kOn = false;

  @override
  void initState() {
    super.initState();
    getInstance();
    localNotif.initialize(const InitializationSettings(AndroidInitializationSettings('icon'), null));
    KeyboardVisibilityNotification().addNewListener(onChange: (bool visible) => setState(() => kOn = visible));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: names == null && start == null
      ? const CircularProgressIndicator()
      : start == false && names != null
      ? checkIntro()
      : Stack(
        children: <Widget>[
          PageView.builder(
            onPageChanged: (int index) => pIndex.value = index,
            itemBuilder: (BuildContext context, int index) {
              return Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: textField(index, 1, names[index], Entry.name, 'Title'),
                ),
                textField(index, kOn ? 15 : 23, texts[index], Entry.text, 'Note'),
              ]);
            },
            itemCount: 4,
          ),
          _buildIndex(),
        ],
      ),
    );
  }

  Widget _buildIndex() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.95),
      child: PageViewIndicator(
        pageIndexNotifier: pIndex,
        length: 4,
        normalBuilder: (AnimationController aControl) => Circle(size: 8.0, color: Colors.lightBlueAccent),
        highlightedBuilder: (AnimationController aControl) => ScaleTransition(
          scale: CurvedAnimation(parent: aControl, curve: Curves.ease),
          child: Circle(size: 11.0, color: Colors.blue),
        ),
      ),
    );
  }

  Widget textField(int index, int maxLines, String text, Entry vtc, String hint) {
    final TextEditingController tControl = TextEditingController(text: text);
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
      child: TextField(
        controller: tControl,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration.collapsed(hintText: hint,  hintStyle: const TextStyle(fontSize: 24, color: Colors.black54, fontFamily: 'Roboto-Light')),
        style: const TextStyle(fontSize: 24, color: Colors.black, fontFamily: 'Roboto-Light'),
        maxLines: maxLines,
        onSubmitted: (String value) {
          updateData(index, vtc, tControl.text);
        }
      ),
    );
  }

  Future<void> getInstance() async {
    data = await SharedPreferences.getInstance();
    setState(() {
      names = data.getStringList('names') ?? <String>['', '', '', ''];
      texts = data.getStringList('texts') ?? <String>['', '', '', ''];
      start = data.getBool('start') ?? false;
    });
  }

  Widget checkIntro() {
    return Stack(
      children: <Widget> [
        Center(
          child: FlareActor('assets/intro.flr',
            alignment: Alignment.center,
            fit: BoxFit.fitWidth,
            animation: 'frame',
          ),
        ),
        IconButton(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.48, top: MediaQuery.of(context).size.height*0.9),
          icon: const Icon(Icons.touch_app),
          color: Colors.blue,
          onPressed: () => setState(() {
            data.setBool('start', true);
            getInstance();
          }),
        ),
      ],
    );
  }

  void updateData(int index, Entry vtc, String value) {
    _repeatNotification();
    setState(() {
      getInstance();
      if(vtc == Entry.text) {
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
    final AndroidNotificationDetails aChannel = AndroidNotificationDetails('repeating channel id', 'repeating channel name', 'repeating description');
    final NotificationDetails channel = NotificationDetails(aChannel, null);
    await localNotif.periodicallyShow(0, '${names[rnd]}','${texts[rnd]}', RepeatInterval.Hourly, channel);
  }
}

enum Entry{text, name}