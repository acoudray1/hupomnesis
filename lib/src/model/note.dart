///
/// This object represents a note
/// 
class Note {
  Note({this.name,this.text,});

  // Factory used to create notes from json file
  factory Note.fromJson(Map<String, dynamic> json) => Note(
      name: json['name'],
      text: json['text'],
  );

  // Method used to map string and data in order to write in a json file
  Map<String, dynamic> toJson() => <String, dynamic>{
      'name': name,
      'text': text,
  };

  String name;
  String text;
}
