import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';

class NoteEditionPage extends StatefulWidget {
  @override
  NoteEditionPageState createState() => NoteEditionPageState();
}

class NoteEditionPageState extends State<NoteEditionPage> {
  ZefyrController _controller;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    // Create an empty document or load existing if you have one.
    // Here we create an empty document:
    final NotusDocument document = NotusDocument();
    _controller = ZefyrController(document);
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return ZefyrScaffold(
      child: ZefyrEditor(
        controller: _controller,
        focusNode: _focusNode,
      ),
    );
  }
}