class Note {
  final int id;
  final String title;
  final String content;
  final String createdTime;
  final int color;
  final int isPinned;

  Note(
      {required this.id,
      required this.title,
      required this.content,
      required this.createdTime,
      required this.color,
      required this.isPinned});

  factory Note.fromSqfliteDatabase(Map<String, dynamic> map) => Note(
    id: map['id'],
    title: map['title'] ?? '',
    content: map['content'] ?? '',
    createdTime: map['createdTime'] ?? '',
    color: map['color'] ?? 4294958788,
    isPinned: map['isPinned'] ?? 0,
  );
}
