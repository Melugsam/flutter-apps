import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notekeeper_new/domain/models/note.dart';
import 'package:notekeeper_new/domain/models/notes_db.dart';

class NotesHub extends StatefulWidget {
  const NotesHub({super.key});

  @override
  State<NotesHub> createState() => _NotesHubState();
}

class _NotesHubState extends State<NotesHub> {
  final notesDB = NotesDB();
  Future<List<Note>>? futureNotes;

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  void fetchNotes() {
    setState(() {
      futureNotes = notesDB.fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 26),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Manage Your\nDaily Tasks",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.settings_outlined, size: 32)),
                  ),
                ],
              ),
              const Divider(
                height: 32,
                thickness: 3,
              ),
              ElevatedButton(
                onPressed: () {
                  print(futureNotes);
                },
                child: Text("test"),
              )
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FloatingActionButton(
            backgroundColor: Colors.grey,
            onPressed: () {
              context.go("create-note",extra:NotesDB );
            },
            child: const Icon(
              Icons.add,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
