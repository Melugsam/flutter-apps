import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  String time = currentTime();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromRGBO(233, 244, 251, 1),
        ),
        margin: const EdgeInsets.all(32),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
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
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
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
                style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String currentTime() => DateFormat('dd.MM.yyyy HH:mm')
      .format(DateTime.now().add(const Duration(hours: 3)));
}