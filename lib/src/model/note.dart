import 'package:hupomnesis/src/model/enum_color_selected.dart';
import 'package:hupomnesis/src/model/enum_status.dart';

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

  // Factory used to create notes from json file
  factory Note.fromJson(Map<String, dynamic> json) => Note(
      id: json['id'],
      text: json['text'],
      status: statusValues.map[json['status']],
      colorSelected: colorSelectedValues.map[json['colorSelected']],
  );

  // Method used to map string and data in order to write in a json file
  Map<String, dynamic> toJson() => <String, dynamic>{
      'id': id,
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