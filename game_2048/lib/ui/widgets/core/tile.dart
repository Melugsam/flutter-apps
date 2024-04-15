import 'package:flutter/material.dart';
import 'package:game_2048/data/colors.dart';

class Tile extends StatelessWidget {
  final double size;
  final int number;

  const Tile({super.key, required this.size, required this.number});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.all(4),
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: numTileColor[number],
        borderRadius: BorderRadius.circular(8)
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: TextStyle(
              color: numTextColor[number],
              fontSize: size / 3,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
