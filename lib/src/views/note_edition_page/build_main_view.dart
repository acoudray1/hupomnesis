import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hupomnesis/src/model/enum_edition_status.dart';
import 'package:hupomnesis/src/views/note_edition_page/note_edition_page_root.dart';
import 'package:hupomnesis/theme/style_texte.dart';
import 'package:hupomnesis/utils/markdown_help_sample.dart';
import 'package:flutter_html/flutter_html.dart';

///
/// Builds the Main View for the text edition page
/// 
class BuildMainView extends StatefulWidget {

  const BuildMainView({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  _BuildMainViewState createState() => _BuildMainViewState();
}

class _BuildMainViewState extends State<BuildMainView> {

  TextEditingController _textEditingController;

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
    final NoteEditionPageRoot noteEditionPageRoot = NoteEditionPageRoot.of(context);
    
    return WillPopScope(
      onWillPop: () => noteEditionPageRoot.noteBloc.updateNote(_textEditingController.text, noteEditionPageRoot.index, noteEditionPageRoot.status),
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            buildHeader(noteEditionPageRoot),
            StreamBuilder<EditionStatus>(
              stream: noteEditionPageRoot.noteEditionPageBloc.editionStatusStream,
              initialData: noteEditionPageRoot.noteEditionPageBloc.editionStatus,
              builder: (BuildContext context, AsyncSnapshot<EditionStatus> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data == EditionStatus.WRITING ? buildTextEditor(noteEditionPageRoot) : buildMarkdownRendering();
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
  SliverAppBar buildHeader(NoteEditionPageRoot noteEditionPageRoot) {
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
                  onPressed: () {
                    noteEditionPageRoot.noteBloc.updateNote(_textEditingController.text, noteEditionPageRoot.index, noteEditionPageRoot.status);
                    Navigator.of(context).pop();
                  },
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.remove_red_eye),
                      onPressed: () {
                        if (noteEditionPageRoot.noteEditionPageBloc.editionStatus == EditionStatus.WRITING)
                          noteEditionPageRoot.noteBloc.updateNote(_textEditingController.text, noteEditionPageRoot.index, noteEditionPageRoot.status);
                        noteEditionPageRoot.noteEditionPageBloc.toggleEditionMode();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.help_outline),
                      onPressed: () => buildHelpPopup(context),
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
  /// Builds Text Editor
  /// 
  SliverFillRemaining buildTextEditor(NoteEditionPageRoot noteEditionPageRoot) {
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

  ///
  /// Builds the markdown rendering
  /// 
  SliverFillRemaining buildMarkdownRendering() {
    return SliverFillRemaining(
      child: Markdown(
        data: _textEditingController.text,
      ),
    );
  }

  ///
  /// Builds the help popup
  /// 
  Future<void> buildHelpPopup(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
          ),
          title: Center(child: Text('MARKDOWN GUIDE', style: Style.subtitleTextStyle.copyWith(fontWeight: FontWeight.w500),)),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              height: MediaQuery.of(context).size.height*0.6,
              width: MediaQuery.of(context).size.width*0.8,
              child: ListView(
                children: <Widget>[
                  Html(data: markdownSampleHtml, useRichText: true,)
                  //Text(markdownSample, style: Style.commonTextStyle, textAlign: TextAlign.justify,),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}