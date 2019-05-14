import 'package:flutter/material.dart';

class BuildWritingModeBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(offset: const Offset(0, 0.2), color: Colors.grey)
        ],
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          IconButton(icon: Icon(Icons.repeat),),
          IconButton(icon: Icon(Icons.repeat),),
          IconButton(icon: Icon(Icons.repeat),),
          IconButton(icon: Icon(Icons.repeat),),
          IconButton(icon: Icon(Icons.repeat),),
          IconButton(icon: Icon(Icons.repeat),),
          IconButton(icon: Icon(Icons.repeat),),
          IconButton(icon: Icon(Icons.repeat),),
          IconButton(icon: Icon(Icons.repeat),),
          IconButton(icon: Icon(Icons.repeat),),
          IconButton(icon: Icon(Icons.repeat),),
          IconButton(icon: Icon(Icons.repeat),),
        ],
      ),
    );
  }
}