import 'package:flutter/material.dart';

class BuildHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: Container(),
      elevation: 1.0,
      pinned: true,
      backgroundColor: Colors.white,
      flexibleSpace: Column(
        children: <Widget>[
          Container(
            color: Colors.blue,
            height: 24.0,
          ),
          Container(
            height: 50,
            color: Colors.white,
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
      ), 
    );
  }
}