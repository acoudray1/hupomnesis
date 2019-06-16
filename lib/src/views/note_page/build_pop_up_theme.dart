import 'package:flutter/material.dart';
import 'package:hupomnesis/theme/style_texte.dart';

class BrightnessSwitcherPopup extends StatelessWidget {
  const BrightnessSwitcherPopup({Key key, this.onSelectedTheme})
      : super(key: key);

  final ValueChanged<Brightness> onSelectedTheme;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Center(child: Text('Select Theme', style: Style.titleTextStyle.copyWith(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),)),
      children: <Widget>[
        const SizedBox(height: 12.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  elevation: Theme.of(context).brightness == Brightness.dark ? 0.0 : 12.0,
                  onPressed: () {
                    onSelectedTheme(Brightness.light);
                    Navigator.pop(context);
                  },
                  shape: CircleBorder(side: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).accentColor, width: 2.0)),
                ),
                const SizedBox(height: 12.0,),
                const Center(child: Text('Light Theme'),),
              ],
            ),
            Column(
              children: <Widget>[
                FloatingActionButton(
                  backgroundColor: const Color(0xFF202124),
                  elevation: Theme.of(context).brightness == Brightness.dark ? 12.0 : 0.0,
                  onPressed: () {
                    onSelectedTheme(Brightness.dark);
                    Navigator.pop(context);
                  },
                  shape: CircleBorder(side: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).accentColor : const Color(0xFF202124))),
                ),
                const SizedBox(height: 12.0,),
                const Center(child: Text('Dark Theme'),),
              ],
            )
          ],
        ),
      ],
    );
  }
}
