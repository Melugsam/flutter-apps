import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotesHub extends StatelessWidget {
  const NotesHub({super.key});

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
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FloatingActionButton(
            backgroundColor: Colors.grey,
            onPressed: () {
              context.go("/create-note");
            },
            child: const Icon(Icons.add, size: 24,),
          ),
        ),
      ),
    );
  }
}
