import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'editNote.dart';
import 'note.dart';
import 'themes.dart';
import 'newNote.dart';
import 'settingsBar.dart';
import 'package:provider/provider.dart';
import 'themeListener.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => themeListener()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteBook',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<themeListener>(context).darkTheme
          ? ThemeClass.darkTheme
          : ThemeClass.lightTheme,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Note> notes = [];
  Set<Note> selectedNotes = <Note>{};
  double bottomNavBarHeight = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _updateBottomNavBarHeight() {
    setState(() {
      if (selectedNotes.length > 0) {
        bottomNavBarHeight = kBottomNavigationBarHeight;
      } else {
        bottomNavBarHeight = 0.0;
      }
    });
  }

  void _addNoteToList(Note note) {
    setState(() {
      notes.add(note);
    });
  }

  void _changeNote(Note note, int index) {
    setState(() {
      notes[index].header = note.header;
      notes[index].text = note.text;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.width * 0.07 + 15,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              iconSize: MediaQuery.of(context).size.width * 0.07.clamp(0, 0.07),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => settingsBar(),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.06),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Количество элементов в строке
            mainAxisSpacing: MediaQuery.of(context).size.width * 0.02,
            crossAxisSpacing: MediaQuery.of(context).size.width *
                0.02, // Отступы между элементами по поперечной оси (горизонтально)
          ),
          shrinkWrap: true,
          itemCount: notes.length,
          itemBuilder: (context, index) {
            Note note = notes[index];
            return GestureDetector(
              onLongPress: () {
                setState(() {
                  if (!note.isSelected) {
                    note.isSelected = !note.isSelected;
                    selectedNotes.add(note);
                  }
                  _updateBottomNavBarHeight();
                });
              },
              onTap: () {
                setState(() {
                  if (selectedNotes.isNotEmpty) {
                    if (selectedNotes.contains(note)) {
                      selectedNotes.remove(note);
                      note.isSelected = false;
                    } else {
                      selectedNotes.add(note);
                      note.isSelected = true;
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return EditNoteDialog(
                          note: note,
                          index: index,
                          onSave: (note) {
                            _changeNote(note, index);
                          },
                        );
                      },
                    );
                  }
                  _updateBottomNavBarHeight();
                });
              },
              child: Stack(
                children: [
                  AnimatedContainer(
                    height: double.infinity,
                    width: double.infinity,
                    duration: Duration(milliseconds: 150),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.all(13.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0),
                      color: Color.fromARGB(93, 169, 171, 174),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          note.header,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.075.clamp(0, 0.075),
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1, // Максимальное количество строк
                          overflow: TextOverflow
                              .ellipsis, // Обрезать текст с многоточием
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.023),
                          child: Text(
                            note.text,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05.clamp(0, 0.05),
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1, // Максимальное количество строк
                            overflow: TextOverflow
                                .ellipsis, // Обрезать текст с многоточием
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.02),
                          child: Text(
                            note.date,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035.clamp(0, 0.035),
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1, // Максимальное количество строк
                            overflow: TextOverflow
                                .ellipsis, // Обрезать текст с многоточием
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: AnimatedOpacity(
                      opacity: note.isSelected ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      child: Icon(
                        Icons.check_circle,
                        color: const Color.fromARGB(255, 97, 205, 255),
                        size: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.all(10),
        child: FloatingActionButton(
          onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => newNode(
                    onSave: (note) {
                      _addNoteToList(note);
                    },
                  )),
          backgroundColor: Colors.amber,
          foregroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            size: 25,
          ),
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 300),
          height: bottomNavBarHeight,
          child: Wrap(children: [buildBottomMenu()])),
    );
  }

  Widget buildBottomMenu() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.delete), label: 'Удалить'),
        BottomNavigationBarItem(icon: Icon(Icons.share), label: 'Поделиться'),
      ],
      onTap: (index) {
        if (index == 0) {
          deleteSelectedNotes();
        } else if (index == 1) {
          shareSelectedNotes();
        }
      },
    );
  }

  void deleteSelectedNotes() {
    setState(() {
      notes.removeWhere((note) => selectedNotes.contains(note));
      selectedNotes.clear();
      _updateBottomNavBarHeight();
    });
  }

  void shareSelectedNotes() {
    // Ваша логика для "Поделиться" выбранными заметками
  }
}
