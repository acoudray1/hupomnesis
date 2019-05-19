import 'package:flutter/material.dart';
import 'package:hupomnesis/src/model/enum_edition_status.dart';
import 'package:hupomnesis/src/views/note_edition_page/note_edition_page_root.dart';

///
/// Builds the Main View for the text edition page
/// 
class BuildMainView extends StatefulWidget {

  const BuildMainView({
    Key key,
    @required this.text
  }) : super(key: key);

  final String text;

  @override
  _BuildMainViewState createState() => _BuildMainViewState();
}

class _BuildMainViewState extends State<BuildMainView> {

  TextEditingController _textEditingController;
  NoteEditionPageRoot noteEditionPageRoot;

  ///
  /// init the textEditingController and allow us to not be initialized at the beginning of the text field each time we tap the text field
  /// 
  @override
  void initState() {
    _textEditingController = TextEditingController(text: widget.text);
    _textEditingController.addListener(() {
      final String text = _textEditingController.text;
      _textEditingController.value = _textEditingController.value.copyWith(
        text: text,
        selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    noteEditionPageRoot = NoteEditionPageRoot.of(context);
    
    return WillPopScope(
      onWillPop: noteEditionPageRoot.noteEditionPageBloc.saveAndPop,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            buildHeader(),
            StreamBuilder<EditionStatus>(
              stream: noteEditionPageRoot.noteEditionPageBloc.editionStatusStream,
              initialData: noteEditionPageRoot.noteEditionPageBloc.editionStatus,
              builder: (BuildContext context, AsyncSnapshot<EditionStatus> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data == EditionStatus.WRITING ? buildTextEditor() : Container();
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// Build the Header
  /// 
  SliverAppBar buildHeader() {
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
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.remove_red_eye),
                      onPressed: () => true,
                    ),
                    IconButton(
                      icon: const Icon(Icons.help_outline),
                      onPressed: () => true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ), 
    );
  }

  ///
  /// Build Text Editor
  /// 
  SliverFillRemaining buildTextEditor() {
    return SliverFillRemaining(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextField(
          decoration: InputDecoration.collapsed(
            hintText: noteEditionPageRoot.note.text,
            hintStyle: const TextStyle(fontSize: 24,
              color: Colors.black54,
              fontFamily: 'Roboto-Light'),
            ),
          autofocus: false,
          maxLines: null,
          controller: _textEditingController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.newline,
        ),
      ),
    );
  }
}