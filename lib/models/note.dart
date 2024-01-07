
import 'package:hive/hive.dart';

// box to store all the notes data on phone
late Box notesBox;

class Note {
  final int id;
  final String title;
  final String description;

  Note({required this.id, required this.title, required this.description});

  ///converting object to map
  Map<String, dynamic> toJson()
    => {
      'id': id,
      'title': title,
      'description': description,
    };

  ///parsing json data to object
  factory Note.fromJson(Map<dynamic, dynamic> json)=>
     Note(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
    );

  deleteNote(){
    notesBox.delete(id);
  }

  addOrUpdateNote(){
    notesBox.put(id, toJson());
  }

  static Note getNote(int id) {
    var data = notesBox.get(id);
    return Note.fromJson(data);
  }

  /// get us the all the notes
  static List<Note>fetchNotes(){
    List<Note> notes = [];
    var data =  notesBox.values.toList();

      data.forEach((item) {
        var note = Note.fromJson(item);
        notes.add(note);
      });
    return notes;
  }
}