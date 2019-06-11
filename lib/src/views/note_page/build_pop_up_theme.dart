import 'package:flutter/material.dart';

class BrightnessSwitcherPopup extends StatelessWidget {
  const BrightnessSwitcherPopup({Key key, this.onSelectedTheme})
      : super(key: key);

  final ValueChanged<Brightness> onSelectedTheme;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Center(child: Text('Select Theme')),
      children: <Widget>[
        const SizedBox(height: 4.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  elevation: Theme.of(context).brightness == Brightness.dark ? 0.0 : 12.0,
                  onPressed: () => onSelectedTheme(Brightness.light),
                  shape: CircleBorder(side: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).accentColor)),
                ),
                const SizedBox(height: 12.0,),
                const Center(child: Text('Light Theme'),),
              ],
            ),
            Column(
              children: <Widget>[
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  elevation: Theme.of(context).brightness == Brightness.dark ? 12.0 : 0.0,
                  onPressed: () => onSelectedTheme(Brightness.dark),
                  shape: CircleBorder(side: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).accentColor : Colors.black)),
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
