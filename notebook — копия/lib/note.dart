final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    id, header, text, date
  ];

  static final String id = '_id';
  static final String header = "header";
  static final String text = "text";
  static final String date = "date";
}

class Note {
  int? id;
  String header;
  String text;
  String date;
  bool isSelected=false;
  
  Note({
    this.id,
    required this.header,
    required this.text,
    required this.date,
  });

  Note copy({
    int? id,
    String? header,
    String? text,
    String? date,
  }) => Note(
    id: id ?? this.id,
    header: header ?? this.header,
    text: text ?? this.text,
    date: date ?? this.date,
  );

  static Note fromJson(Map<String, Object?> json) => Note(
    id: json[NoteFields.id] as int?,
    header: json[NoteFields.header] as String,
    text: json[NoteFields.text] as String,
    date: json[NoteFields.date] as String,
  );

  Map<String, Object?> toJson() => {
    NoteFields.id: id,
    NoteFields.header: header,
    NoteFields.text: text,
    NoteFields.date: date
  };
}