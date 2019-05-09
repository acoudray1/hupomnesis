import 'package:hupomnesis/src/resources/enum_manager.dart';

///
/// Represents the different colors that a user can choose for his notes
/// 
enum ColorSelected {
  NORMAL, 
  BLUE, 
  GREEN,
  YELLOW,
  PURPLE,
  RED,
}

final EnumManager<ColorSelected> colorSelectedValues = EnumManager<ColorSelected> (<String, ColorSelected> {
    'NORMAL': ColorSelected.NORMAL,
    'BLUE': ColorSelected.BLUE,
    'GREEN': ColorSelected.GREEN,
    'YELLOW': ColorSelected.YELLOW,
    'PURPLE': ColorSelected.PURPLE,
    'RED': ColorSelected.RED,
});