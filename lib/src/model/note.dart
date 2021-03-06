import 'package:hupomnesis/src/model/enum_color_selected.dart';
import 'package:hupomnesis/src/model/enum_status.dart';

const String tableNote = 'note';
const String columnId = '_id';
const String columnText = 'text';
const String columnColorSelected = 'colorSelected';
const String columnStatus = 'status';

///
/// This object represents a note
/// 
class Note {
  Note({
    this.id,
    this.text,
    this.status,
    this.colorSelected,
  });

  ///
  /// Factory used to create notes from json file
  /// 
  factory Note.fromJson(Map<String, dynamic> json) => Note(
      text: json['text'],
      status: statusValues.map[json['status']],
      colorSelected: colorSelectedValues.map[json['colorSelected']],
  );

  ///
  /// Factory used to create a note from the database instance
  /// 
  factory Note.fromMap(Map<String, dynamic> map) => Note(
    id: map[columnId],
    text: map[columnText],
    status: statusValues.map[map[columnStatus]],
    colorSelected: colorSelectedValues.map[map[columnColorSelected]],
  );

  ///
  /// Method used to map string and data in order to write it in database instance
  ///
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{
      columnText: text,
      columnStatus: statusValues.reverse[status],
      columnColorSelected: colorSelectedValues.reverse[colorSelected]
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  // Method used to map string and data in order to write in a json file
  Map<String, dynamic> toJson() => <String, dynamic>{
      'text': text,
      'status': statusValues.reverse[status],
      'colorSelected': colorSelectedValues.reverse[colorSelected],
  };

  int id;
  String text;
  Status status;
  ColorSelected colorSelected;
  bool isSelected = false;
}