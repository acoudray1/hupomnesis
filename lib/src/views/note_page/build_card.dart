import 'package:flutter/material.dart';
import 'package:hupomnesis/src/model/note.dart';
import 'package:hupomnesis/theme/text_style.dart';

///
/// Widget that builds a card
/// 
Widget buildCard(BuildContext context, int index, List<Note> notes) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(1.0, 2.0, 0.0, 2.0),
    child: Stack(
      children: <Widget>[
        Positioned(
          top: 2.0,
          bottom: 2.0,
          left: 2.0,
          right: 2.0,
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(4.0)
            ),
            color: Colors.white,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(70),
              // TODO(interactions): Implement actions
              onTap: () {},
              onLongPress: () => true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${notes[index].name}', style: Style.subtitleTextStyle, textAlign: TextAlign.start,),
                    const SizedBox(height: 1.0,),
                    Text('${notes[index].text}', style: Style.commonTextStyle, textAlign: TextAlign.justify,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}