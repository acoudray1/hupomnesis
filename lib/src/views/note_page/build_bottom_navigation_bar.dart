import 'package:flutter/material.dart';
import 'package:hupomnesis/src/views/note_page/note_page_root.dart';
import 'package:hupomnesis/theme/custom_bottom_nav_bar.dart';

class BuildBottomNavBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final NotePageRoot notePageRoot = NotePageRoot.of(context);
    
    return StreamBuilder<int>(
      initialData: notePageRoot.noteNavigationBloc.pageIndex,
      stream: notePageRoot.noteNavigationBloc.pageIndexStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasData) {
          return CustomBottomNavigationBar(
            type: CustomBottomNavigationBarType.spotifyLike,
            iconSize: 22.0,
            currentIndex: snapshot.data,
            items: notePageRoot.noteNavigationBloc.bottomNavBarItems,
            onTap: notePageRoot.noteNavigationBloc.handleNavigation,
          );
        } else {
          return Container();
        }
      },
    );

    
  }
}