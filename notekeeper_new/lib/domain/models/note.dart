class Note {
  final int id;
  final String title;
  final String content;
  final String createdTime;
  final String textColor;
  final bool isPinned;

  Note(
      {required this.id,
      required this.title,
      required this.content,
      required this.createdTime,
      required this.textColor,
      required this.isPinned});

  factory Note.fromSqfliteDatabase(Map<String, dynamic> map) => Note(
    id: map['id'],
    title: map['title'],
    content: map['content'],
    createdTime: map['createdTime'],
    textColor: map['textColor'],
    isPinned: map['isPinned'],
  );
}
