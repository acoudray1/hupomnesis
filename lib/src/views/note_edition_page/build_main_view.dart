import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hupomnesis/src/model/enum_edition_status.dart';
import 'package:hupomnesis/src/views/note_edition_page/note_edition_page_root.dart';
import 'package:hupomnesis/theme/style_icons.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final NoteEditionPageRoot noteEditionPageRoot = NoteEditionPageRoot.of(context);
    _textEditingController..addListener(() => noteEditionPageRoot.noteEditionPageBloc.handleTextEdited(widget.text, _textEditingController.text),);
    
    return WillPopScope(
      onWillPop: () {
        if(noteEditionPageRoot.note == null) {
          noteEditionPageRoot.noteBloc.createNote(_textEditingController.text);
        } else {
          if(noteEditionPageRoot.note.text != _textEditingController.text) {
            noteEditionPageRoot.note.text = _textEditingController.text;
            noteEditionPageRoot.noteBloc.updateNote(noteEditionPageRoot.note);
          }
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            buildHeader(noteEditionPageRoot),
            StreamBuilder<EditionStatus>(
              stream: noteEditionPageRoot.noteEditionPageBloc.editionStatusStream,
              initialData: noteEditionPageRoot.editionStatus,
              builder: (BuildContext context, AsyncSnapshot<EditionStatus> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data == EditionStatus.WRITING ? buildTextEditor(noteEditionPageRoot, context) : buildMarkdownRendering();
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
      backgroundColor: Theme.of(context).backgroundColor,
      flexibleSpace: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            height: 24.0,
          ),
          AnimatedContainer(
            duration: Duration(seconds: 0),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
              color: Theme.of(context).backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(offset: const Offset(0, 0.2), color: Theme.of(context).brightness == Brightness.dark ? Colors.white10 : Colors.black12,)
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                StreamBuilder<IconData>(
                  stream: noteEditionPageRoot.noteEditionPageBloc.backIconStream,
                  initialData: noteEditionPageRoot.noteEditionPageBloc.backIcon,
                  builder: (BuildContext context, AsyncSnapshot<IconData> snapshot) {
                    if (snapshot.hasData) {
                      return IconButton(
                        icon: Icon(snapshot.data, color: snapshot.data == Icons.done ? Theme.of(context).buttonColor : Theme.of(context).accentColor),
                        onPressed: () {
                          if(noteEditionPageRoot.note == null) {
                            noteEditionPageRoot.noteBloc.createNote(_textEditingController.text);
                          } else {
                            if(noteEditionPageRoot.note.text != _textEditingController.text) {
                              noteEditionPageRoot.note.text = _textEditingController.text;
                              noteEditionPageRoot.noteBloc.updateNote(noteEditionPageRoot.note);
                            }
                          }
                          Navigator.of(context).pop();
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                StreamBuilder<EditionStatus>(
                  stream: noteEditionPageRoot.noteEditionPageBloc.editionStatusStream,
                  initialData: noteEditionPageRoot.noteEditionPageBloc.editionStatus,
                  builder: (BuildContext context, AsyncSnapshot<EditionStatus> snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(noteEditionPageRoot.noteEditionPageBloc.editionStatus == EditionStatus.WRITING 
                              ? StyleIcons.eye
                              : StyleIcons.eye_off, color: Theme.of(context).buttonColor,),
                            onPressed: () {
                              if (noteEditionPageRoot.noteEditionPageBloc.editionStatus == EditionStatus.WRITING) {
                                if(noteEditionPageRoot.note == null) {
                                  noteEditionPageRoot.noteBloc.createNote(_textEditingController.text);
                                } else {
                                  if(noteEditionPageRoot.note.text != _textEditingController.text) {
                                    noteEditionPageRoot.note.text = _textEditingController.text;
                                    noteEditionPageRoot.noteBloc.updateNote(noteEditionPageRoot.note);
                                  }
                                }
                              }
                              noteEditionPageRoot.noteEditionPageBloc.toggleEditionMode();
                            },
                            splashColor: Colors.transparent,
                          ),
                          IconButton(
                            icon: Icon(Icons.help_outline, color: Theme.of(context).buttonColor,),
                            onPressed: () => buildHelpPopup(context),
                            splashColor: Colors.transparent,
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
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
  SliverFillRemaining buildTextEditor(NoteEditionPageRoot noteEditionPageRoot, BuildContext context) {
    return SliverFillRemaining(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextField(
          style: TextStyle(fontSize: 14,
            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
            fontFamily: 'Roboto-Light'),
          cursorColor: Theme.of(context).accentColor,
          decoration: InputDecoration.collapsed(
            hintText: 'Write your note',
          ),
          enableInteractiveSelection: true,
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
        padding: const EdgeInsets.all(4.0),
        /*styleSheet: MarkdownStyleSheet().copyWith(
          a: const TextStyle(fontSize: 16,
            color: Colors.black,
            fontFamily: 'Roboto-Light'),
          codeblockDecoration: BoxDecoration(
            color: Colors.grey,
          )
        )*/
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
          title: Center(child: Text('MARKDOWN GUIDE', style: Style.subtitleTextStyle.copyWith(fontWeight: FontWeight.w500, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),)),
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