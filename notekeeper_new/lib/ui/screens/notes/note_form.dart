// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:notekeeper_new/data/note_colors.dart';
import 'package:notekeeper_new/domain/models/note.dart';
import 'package:notekeeper_new/domain/models/notes_db.dart';

class NoteForm extends StatefulWidget {
  final Note? note;
  final NotesDB notesDB;

  const NoteForm({super.key, required this.notesDB, this.note});

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  String time = currentTime();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  Color containerColor = const Color.fromRGBO(233, 244, 251, 1);
  int isPinned = 0;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
      containerColor = Color(widget.note!.color);
      isPinned = widget.note!.isPinned;
    } else {
      containerColor = getRandomColor();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    onPressed: () async {
                      if (widget.note != null) {
                        await widget.notesDB.delete(widget.note!.id);
                        if (mounted) {
                          context.go("/notes-hub");
                        }
                      } else {
                        if (mounted) {
                          context.go("/notes-hub");
                        }
                      }
                    },
                    icon: const Icon(Icons.delete, size: 32),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  IconButton(
                    onPressed: () async {
                      if (widget.note != null) {
                        await widget.notesDB.update(
                            id: widget.note!.id,
                            title: titleController.text,
                            content: contentController.text,
                            createdTime: time,
                            color: containerColor.value,
                            isPinned: isPinned);
                        if (mounted) {
                          context.go("/notes-hub");
                        }
                      } else {
                        await widget.notesDB.create(
                          title: titleController.text,
                          content: contentController.text,
                          createdTime: time,
                          color: containerColor.value,
                          isPinned: isPinned,
                        );
                        if (mounted) {
                          context.go("/notes-hub");
                        }
                      }
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
                            onPressed: () {
                              setState(() {
                                isPinned = 1 - isPinned;
                              });
                            },
                            icon: Icon(isPinned == 1
                                ? Icons.push_pin
                                : Icons.push_pin_outlined),
                          ),
                          IconButton(
                            onPressed: () {
                              showColorPicker();
                            },
                            icon: const Icon(Icons.color_lens_outlined),
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

  void showColorPicker() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Выберите цвет"),
            content: SingleChildScrollView(
              child: ColorPicker(
                onColorChanged: (value) {
                  setState(() {
                    containerColor=value;
                  });
                },
                pickerColor: const Color.fromRGBO(255, 255, 255, 1.0),
                paletteType: PaletteType.hueWheel,
              ),
            ),
          );
        });
  }
}


