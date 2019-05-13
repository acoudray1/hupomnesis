import 'package:flutter/material.dart';

class BuildHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.blue,
          height: 24.0,
        ),
        Container(
          height: 72,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(offset: const Offset(0, 0.2), color: Colors.grey)
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
              IconButton(
                icon: const Icon(Icons.remove_red_eye),
                onPressed: () => true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}