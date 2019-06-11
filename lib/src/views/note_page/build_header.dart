import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:hupomnesis/src/model/enum_color_selected.dart';
import 'package:hupomnesis/src/views/note_edition_page/note_edition_page.dart';
import 'package:hupomnesis/src/views/note_page/build_pop_up_theme.dart';
import 'package:hupomnesis/src/views/note_page/note_page_root.dart';
import 'package:hupomnesis/theme/style_icons.dart';
import 'package:hupomnesis/theme/style_texte.dart';
import 'package:hupomnesis/theme/theme_data.dart';

///
/// Builds the header of the main view
/// 
class BuildHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final NotePageRoot notePageRoot = NotePageRoot.of(context);

    return StreamBuilder<bool>(
      stream: notePageRoot.noteSelectionBloc.isSelectingStream,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if(snapshot.hasData) {
          return Column(
            children: <Widget>[
              Container(
                color: Theme.of(context).primaryColor,
                height: 24.0,
              ),
              AnimatedContainer(
                height: 72,
                duration: Duration(seconds: 0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                  color: Theme.of(context).backgroundColor,
                  boxShadow: <BoxShadow>[
                    BoxShadow(offset: const Offset(0, 0.2), color: Theme.of(context).brightness == Brightness.dark ? Colors.white10 : Colors.black12,)
                  ]
                ),
                child: snapshot.data 
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.close, color: Theme.of(context).accentColor,),
                          splashColor: Colors.transparent,
                          onPressed: () {
                            notePageRoot.noteSelectionBloc.handleCompleteDiscard(notePageRoot.noteBloc.notes);
                          },
                        ),
                        Text('${notePageRoot.noteSelectionBloc.numberOfNotesSelected}', 
                          style: Style.subtitleTextStyle.copyWith(color: Theme.of(context).buttonColor, fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ]
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon:  Icon(StyleIcons.pin, color: Theme.of(context).buttonColor,),
                          splashColor: Colors.transparent,
                          onPressed: () =>
                            notePageRoot.noteBloc.noteToPinned(listOfNotes: notePageRoot.noteBloc.notes, noteSelectionBloc: notePageRoot.noteSelectionBloc),
                        ),
                        IconButton(
                          icon: Icon(Icons.archive, color: Theme.of(context).buttonColor,),
                          splashColor: Colors.transparent,
                          onPressed: () =>
                            notePageRoot.noteBloc.noteToArchived(listOfNotes: notePageRoot.noteBloc.notes, noteSelectionBloc: notePageRoot.noteSelectionBloc),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Theme.of(context).buttonColor,),
                          splashColor: Colors.transparent,
                          onPressed: () =>
                            notePageRoot.noteBloc.deleteNote(listOfNotes: notePageRoot.noteBloc.notes, noteSelectionBloc: notePageRoot.noteSelectionBloc),
                        ),
                        PopupMenuButton<ColorSelected>(
                          icon: Icon(Icons.color_lens, color: Theme.of(context).buttonColor,),
                          offset: const Offset(100,100),
                          padding: const EdgeInsets.all(0.0),
                          tooltip: 'Choose a color for your notes!',
                          onSelected: (ColorSelected colorSelected) => 
                            notePageRoot.noteBloc.changeColor(listOfNotes: notePageRoot.noteBloc.notes, noteSelectionBloc: notePageRoot.noteSelectionBloc, colorSelected: colorSelected),
                          itemBuilder: (BuildContext context) => <PopupMenuEntry<ColorSelected>> [
                            buildPopupMenuItem(ColorSelected.YELLOW, 'YELLOW', Colors.yellow, context),
                            buildPopupMenuItem(ColorSelected.BLUE, 'BLUE', Colors.blue, context),
                            buildPopupMenuItem(ColorSelected.GREEN, 'GREEN', Colors.green, context),
                            buildPopupMenuItem(ColorSelected.PURPLE, 'PURPLE', Colors.purple, context),
                            buildPopupMenuItem(ColorSelected.RED, 'RED', Colors.red, context),
                          ],
                        ),
                      ],
                    ),
                  ],
                ) : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    MaterialButton(
                      height: 72,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute<NoteEditionPage>(
                          builder: (BuildContext context) => NoteEditionPage(
                            noteBloc: notePageRoot.noteBloc,
                          )));
                      },
                      child: Text('Create a new note...', style: Style.commonTextStyle.copyWith(color: Theme.of(context).brightness == Brightness.dark ? Colors.white54 : Colors.black54),),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Theme.of(context).brightness == Brightness.dark ? Icons.brightness_2 : StyleIcons.wb_sunny, color: Theme.of(context).buttonColor,),
                          onPressed: () => showChooser(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 1.0,)
            ],
          );
        } else {
          return Container();
        }
      }
    );
  }

  ///
  /// Function that builds PopupMenuItem for PopupMenuButton
  /// 
  PopupMenuItem<ColorSelected> buildPopupMenuItem(ColorSelected colorSelected, String textToDisplay, Color color, BuildContext context) {

    return PopupMenuItem<ColorSelected>(
      value: colorSelected,
      child: ListTile(
        leading: Icon(Icons.brightness_1, color: color,),
        title: Text('$textToDisplay', style: Style.smallTextStyle.copyWith(color: Theme.of(context).brightness == Brightness.dark ? Colors.white54 : Colors.black54),),
      ),
    );
  }

  void showChooser(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BrightnessSwitcherPopup(
          onSelectedTheme: (Brightness brightness) {
            if(brightness != Theme.of(context).brightness) {
              DynamicTheme.of(context).setBrightness(brightness);
              DynamicTheme.of(context).setThemeData(
                Theme.of(context).brightness == Brightness.dark
                  ? buildLightTheme()
                  : buildDarkTheme()
              );
            }
          },
        );
      }
    );
  }
}