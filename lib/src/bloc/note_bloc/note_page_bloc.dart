import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hupomnesis/src/model/note.dart';

class NotePageBloc {
  
  /// 
  /// Generate tiles instead of the length of the note's text for the sliver grid view
  /// 
  List<StaggeredTile> generateTiles(int count, List<Note> notes) {
    
    final List<double> heights = <double>[];

    for (Note note in notes) {
      if (note.text.runes.length < 50) 
        heights.add(1.5);
      else if (50 <= note.text.runes.length && note.text.runes.length < 100)
        heights.add(2.5);
      else 
        heights.add(3.5);
    }
    
    return List<StaggeredTile>.generate(count,
      (int i) => StaggeredTile.count(2, heights[i]));
  }

  ///
  /// Returns the tiles sizes for the builder
  /// 
  StaggeredTile getTiles(int index, List<StaggeredTile> tiles) {
    return tiles[index];
  } 
}