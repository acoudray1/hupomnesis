import 'dart:math';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NotePageBloc {
  
  /// 
  /// Generate random tiles for the sliver grid view
  /// 
  List<StaggeredTile> generateRandomTiles(int count) {
    final Random rnd = Random();
    return List<StaggeredTile>.generate(count,
      (int i) => StaggeredTile.count(2, rnd.nextInt(3).isEven ? 2.5 : 1.5));
  }

  ///
  /// Returns the tiles sizes for the builder
  /// 
  StaggeredTile getTiles(int index, List<StaggeredTile> tiles) {
    return tiles[index];
  } 
}