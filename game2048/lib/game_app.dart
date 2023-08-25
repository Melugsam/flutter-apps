import 'package:flutter/material.dart';
import 'game_page.dart';

class GameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2048 Game',
      debugShowCheckedModeBanner: false,
      home: GamePage(),
    );
  }
}
