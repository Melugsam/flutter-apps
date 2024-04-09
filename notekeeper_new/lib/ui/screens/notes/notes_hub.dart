import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notekeeper_new/domain/models/note.dart';
import 'package:notekeeper_new/domain/models/notes_db.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notekeeper_new/ui/screens/notes/note_tile.dart';

class NotesHub extends StatefulWidget {
  const NotesHub({super.key});

  @override
  State<NotesHub> createState() => _NotesHubState();
}

class _NotesHubState extends State<NotesHub> {
  final notesDB = NotesDB();
  Future<List<Note>>? futureNotes;
  Map<int, Note> selectedNote = {};

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
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
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
                Expanded(
                  child: FutureBuilder(
                    future: futureNotes,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else {
                        final notes = snapshot.data!;
                        return notes.isEmpty
                            ? const Center(
                                child: Text(
                                  "No Notes",
                                  style: TextStyle(fontSize: 26),
                                ),
                              )
                            : MasonryGridView.count(
                                padding: EdgeInsets.zero,
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                itemCount: notes.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onLongPress: () {
                                      setState(() {
                                        if (selectedNote.containsKey(index)) {
                                          selectedNote.remove(index);
                                        } else {
                                          selectedNote[index] = notes[index];
                                        }
                                      });
                                    },
                                    onTap: () {
                                      context.go("/create-note", extra: {"notesDB":notesDB, "note":notes[index]}, );
                                    },
                                    child: Stack(
                                      children: [
                                        NoteTile(
                                          title: notes[index].title,
                                          content: notes[index].content,
                                          color: notes[index].color,
                                          createdTime: notes[index].createdTime,
                                        ),
                                        AnimatedOpacity(
                                          opacity:
                                              selectedNote.containsKey(index)
                                                  ? 1.0
                                                  : 0.0,
                                          duration:
                                              const Duration(milliseconds: 150),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: CircleAvatar(
                                                backgroundColor: Color.fromRGBO(
                                                    110, 170, 250, 1.0),
                                                radius: 12,
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              backgroundColor: const Color.fromRGBO(44, 44, 44, 1.0),
              onPressed: () {
                context.go("/create-note", extra: {"notesDB":notesDB});
              },
              child: const Icon(
                Icons.note_alt_outlined,
                color: Color.fromRGBO(215, 215, 215, 1.0),
                size: 24,
              ),
            ),
          ),
          bottomNavigationBar: selectedNote.isNotEmpty
              ? BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                        icon: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            for (var note in selectedNote.values) {
                              await notesDB.delete(note.id);
                            }
                            selectedNote.clear();
                            fetchNotes();
                          },
                        ),
                        label: "Delete"),
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.share), label: "Share"),
                  ],
                )
              : const SizedBox()),
    );
  }
}
