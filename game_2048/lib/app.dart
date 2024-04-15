import 'package:flutter/material.dart';
import 'package:game_2048/ui/screens/game_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.openSans.call().fontFamily
      ),
      home: const GameScreen(),
    );
  }
}
