// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notekeeper_new/bloc/screens/notes/notes_hub_bloc.dart';
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
  List<Note> selectedNote = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotesHubBloc>(context)
        .add(FetchNotesEvent(notesDB: notesDB));
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        "Управляйте\nзаметками",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: IconButton(
                          onPressed: () async {
                            await notesDB.deleteAll();
                            setState(() {
                              BlocProvider.of<NotesHubBloc>(context)
                                  .add(FetchNotesEvent(notesDB: notesDB));
                            });
                          },
                          icon: const Icon(Icons.delete_forever, size: 34)),
                    ),
                  ],
                ),
                const Divider(
                  height: 32,
                  thickness: 3,
                ),
                Expanded(
                  child: BlocBuilder<NotesHubBloc, NotesHubState>(
                    builder: (BuildContext context, NotesHubState state) {
                      if (state is NotesLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is NotesFetchedState) {
                        final pinnedNotes = state.pinnedNotes;
                        final unpinnedNotes = state.unpinnedNotes;
                        if (pinnedNotes.isEmpty && unpinnedNotes.isEmpty) {
                          return const Center(
                              child: Text(
                            "Заметки\nотсутствуют",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 26),
                          ));
                        } else {
                          return ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            children: [
                              if (pinnedNotes.isNotEmpty)
                                Column(
                                  children: [
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "закреплены",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color.fromRGBO(
                                                189, 193, 202, 1),
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    MasonryGridView.count(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      itemCount: pinnedNotes.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onLongPress: () {
                                            setState(() {
                                              if (selectedNote.contains(
                                                  pinnedNotes[index])) {
                                                selectedNote
                                                    .remove(pinnedNotes[index]);
                                              } else {
                                                selectedNote
                                                    .add(pinnedNotes[index]);
                                              }
                                            });
                                          },
                                          onTap: () {
                                            context.go(
                                              "/create-note",
                                              extra: {
                                                "notesDB": notesDB,
                                                "note": pinnedNotes[index]
                                              },
                                            );
                                          },
                                          child: Stack(
                                            children: [
                                              NoteTile(
                                                title: pinnedNotes[index].title,
                                                content:
                                                    pinnedNotes[index].content,
                                                color: pinnedNotes[index].color,
                                                createdTime: pinnedNotes[index]
                                                    .createdTime,
                                              ),
                                              AnimatedOpacity(
                                                opacity: selectedNote.contains(
                                                        pinnedNotes[index])
                                                    ? 1.0
                                                    : 0.0,
                                                duration: const Duration(
                                                    milliseconds: 150),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Color.fromRGBO(110,
                                                              170, 250, 1.0),
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
                                    ),
                                  ],
                                ),
                              const SizedBox(
                                height: 16,
                              ),
                              if (unpinnedNotes.isNotEmpty)
                                Column(
                                  children: [
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "откреплены",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color.fromRGBO(
                                                189, 193, 202, 1),
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    MasonryGridView.count(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      itemCount: unpinnedNotes.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onLongPress: () {
                                            setState(() {
                                              if (selectedNote.contains(
                                                  unpinnedNotes[index])) {
                                                selectedNote.remove(
                                                    unpinnedNotes[index]);
                                              } else {
                                                selectedNote
                                                    .add(unpinnedNotes[index]);
                                              }
                                            });
                                          },
                                          onTap: () {
                                            context.go(
                                              "/create-note",
                                              extra: {
                                                "notesDB": notesDB,
                                                "note": unpinnedNotes[index]
                                              },
                                            );
                                          },
                                          child: Stack(
                                            children: [
                                              NoteTile(
                                                title:
                                                    unpinnedNotes[index].title,
                                                content: unpinnedNotes[index]
                                                    .content,
                                                color:
                                                    unpinnedNotes[index].color,
                                                createdTime:
                                                    unpinnedNotes[index]
                                                        .createdTime,
                                              ),
                                              AnimatedOpacity(
                                                opacity: selectedNote.contains(
                                                        unpinnedNotes[index])
                                                    ? 1.0
                                                    : 0.0,
                                                duration: const Duration(
                                                    milliseconds: 150),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Color.fromRGBO(110,
                                                              170, 250, 1.0),
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
                                    ),
                                  ],
                                )
                            ],
                          );
                        }
                      } else {
                        return const Center(child: Text("Error"));
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
                context.go("/create-note", extra: {"notesDB": notesDB});
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
                  unselectedItemColor: Colors.blueAccent,
                  selectedItemColor: Colors.blueAccent,
                  items: [
                    BottomNavigationBarItem(
                      label: "Удалить",
                      icon: InkWell(
                        child: const Icon(Icons.delete),
                        onTap: () async {
                          for (var note in selectedNote) {
                            await notesDB.delete(note.id);
                          }
                          setState(() {
                            selectedNote.clear();
                          });
                          if (mounted) {
                            BlocProvider.of<NotesHubBloc>(context)
                                .add(FetchNotesEvent(notesDB: notesDB));
                          }
                        },
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "Убрать",
                      icon: InkWell(
                        child:
                            const Icon(Icons.settings_backup_restore_rounded),
                        onTap: () {
                          setState(() {
                            selectedNote.clear();
                          });
                        },
                      ),
                    ),
                  ],
                )
              : const SizedBox()),
    );
  }
}
