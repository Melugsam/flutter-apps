import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:notekeeper_new/data/note_colors.dart';
import 'package:notekeeper_new/domain/models/notes_db.dart';

class CreateNote extends StatefulWidget {
  final NotesDB notesDB;

  const CreateNote({super.key, required this.notesDB});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  String time = currentTime();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  Color containerColor = const Color.fromRGBO(233, 244, 251, 1);

  @override
  void initState() {
    super.initState();
    containerColor = getRandomColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      context.go("/notes-hub");
                    },
                    icon: const Icon(Icons.arrow_back, size: 32),
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete, size: 32),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  IconButton(
                    onPressed: () async {
                      await widget.notesDB.create(
                          title: titleController.text,
                          content: contentController.text,
                          createdTime: time,
                          color: containerColor.value);
                      if (!mounted) return;
                    },
                    icon: const Icon(Icons.check, size: 32),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: containerColor,
                ),
                margin: const EdgeInsets.all(32),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              time,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(188, 193, 202, 1),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.notifications_none),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.push_pin),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_vert),
                          ),
                        ],
                      ),
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          hintText: "Заголовок",
                          enabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                        ),
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w600),
                      ),
                      TextField(
                        minLines: 1,
                        maxLines: 10,
                        controller: contentController,
                        decoration: const InputDecoration(
                          hintText: "Текст",
                          enabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                        ),
                        style: const TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String currentTime() => DateFormat('dd.MM.yyyy HH:mm')
      .format(DateTime.now().add(const Duration(hours: 3)));
}
