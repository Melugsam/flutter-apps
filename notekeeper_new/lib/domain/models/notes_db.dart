import 'package:notekeeper_new/domain/services/database/database_service.dart';
import 'package:sqflite/sqflite.dart';

import 'note.dart';

class NotesDB {
  final tableName = "notes";

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
    "id" INTEGER NOT NULL,
    "title" TEXT,
    "content" TEXT,
    "createdTime" TEXT,
    "color" INTEGER,
    "isPinned" INTEGER,
    PRIMARY KEY("id" AUTOINCREMENT)
    );""");
  }

  Future<int> create(
      {required String title,
      required String content,
      required String createdTime,
      required int color}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert("""
    INSERT INTO $tableName (title,content,createdTime,color) VALUES (?,?,?,?)""",
        [title, content, createdTime, color]);
  }

  Future<List<Note>> fetchAll() async {
    final database = await DatabaseService().database;
    final notes = await database.rawQuery("""
    SELECT * FROM $tableName""");
    return notes.map((note) => Note.fromSqfliteDatabase(note)).toList();
  }

  Future<Note> fetchById(int id) async {
    final database = await DatabaseService().database;
    final note = await database.rawQuery("""
      SELECT * from $tableName WHERE ID = ?
    """, [id]);
    return Note.fromSqfliteDatabase(note.first);
  }

  Future<int> update(
      {required int id, String? title, String? content, String? createdTime}) async {
    final database = await DatabaseService().database;
    return await database.update(
        tableName,
        {
          if (title != null) 'title': title,
          if (content != null) 'content': content,
          if (createdTime != null) 'createdTime': createdTime,
        },
        where: 'id = ?',
        conflictAlgorithm: ConflictAlgorithm.rollback,
        whereArgs: [id]);
  }
  Future<void> delete(int id) async{
    final database = await DatabaseService().database;
    await database.rawDelete("""DELETE FROM $tableName WHERE ID = ?""", [id]);
  }

  Future<void> deleteAll() async{
    final database = await DatabaseService().database;
    final notes = await database.query(tableName);
    for (var note in notes) {
      await database.rawDelete("""DELETE FROM $tableName WHERE ID = ?""", [note['id']]);
    }
  }
}
