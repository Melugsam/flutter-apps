import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notekeeper_new/bloc/screens/notes/notes_hub_bloc.dart';
import 'package:notekeeper_new/domain/models/note.dart';
import 'package:notekeeper_new/ui/screens/notes/notes_hub.dart';
import 'domain/models/notes_db.dart';
import 'ui/screens/notes/note_form.dart';
import 'ui/screens/welcome/welcome_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final GoRouter _router = GoRouter(navigatorKey: _rootNavigatorKey, routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const WelcomePage(),
  ),
  GoRoute(
    path: '/notes-hub',
    builder: (context, state) => const NotesHub(),
  ),
  GoRoute(
      path: '/create-note',
      builder: (context, state) {
        Map<String, dynamic> extras = state.extra as Map<String, dynamic>;
        if (extras.containsKey("note")) {
          NotesDB notesDB = extras['notesDB'] as NotesDB;
          Note note = extras['note'] as Note;
          return NoteForm(
            notesDB: notesDB,
            note: note,
          );
        } else {
          NotesDB notesDB = extras['notesDB'] as NotesDB;
          return NoteForm(
            notesDB: notesDB,
          );
        }
      }),
]);

class Notekeeper extends StatelessWidget {
  const Notekeeper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NotesHubBloc(),
        )
      ],
      child: MaterialApp.router(
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
        routeInformationProvider: _router.routeInformationProvider,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textTheme: GoogleFonts.epilogueTextTheme(),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
