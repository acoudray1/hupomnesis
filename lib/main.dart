import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:flare_flutter/flare_actor.dart';

void main() {runApp(MaterialApp(title: 'Hupomnesis', home: Home()));
  SystemChrome.setEnabledSystemUIOverlays(<SystemUiOverlay>[]);
}

class Home extends StatefulWidget {
 @override
 _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences data;
  FlutterLocalNotificationsPlugin localNotif = FlutterLocalNotificationsPlugin();
  final ValueNotifier<int> pIndex = ValueNotifier<int>(0);
  bool introduction;
  List<String> names, texts;

  @override
  void initState() {
    super.initState();
    getInstance();
    localNotif.initialize(const InitializationSettings(AndroidInitializationSettings('app_icon'), null));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: names == null && introduction == null
      ? const CircularProgressIndicator()
      : introduction == false && names != null
      ? checkIntro()
      : Stack(
        children: <Widget>[
          PageView.builder(
            onPageChanged: (int index) => pIndex.value = index,
            itemBuilder: (BuildContext context, int index) {
              return Column(children: <Widget>[
                textField(index, 1, names[index], ValueToChange.name, TextAlign.start, 'Title'),
                textField(index, 15, texts[index], ValueToChange.text, TextAlign.justify, 'Note'),
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
        normalBuilder: (AnimationController aController) => Circle(size: 8.0, color: Colors.black54),
        highlightedBuilder: (AnimationController aController) => ScaleTransition(
          scale: CurvedAnimation(parent: aController, curve: Curves.ease),
          child: Circle(size: 11.0, color: Colors.black54),
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
        decoration: InputDecoration.collapsed(hintText: hint, hintStyle: const TextStyle(fontSize: 28, color: Colors.black54, fontFamily: 'Roboto-Light')),
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

  Widget checkIntro() {
    return Stack(
      children: <Widget> [
        Center(
          child: FlareActor('assets/animations/intro.flr',
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
            data.setBool('introduction', true);
            getInstance();
          }),
        ),
      ],
    );
  }

  void updateData(int index, ValueToChange vtc, String value) {
    _repeatNotification();
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
    final AndroidNotificationDetails androidChannel = AndroidNotificationDetails('repeating channel id', 'repeating channel name', 'repeating description');
    final NotificationDetails channel = NotificationDetails(androidChannel, null);
    await localNotif.periodicallyShow(0, '${names[rnd]}','${texts[rnd]}', RepeatInterval.Hourly, channel);
  }
}

enum ValueToChange{ text, name, }