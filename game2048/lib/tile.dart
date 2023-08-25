import 'package:flutter/material.dart';

class Tile {
  int value;
  MaterialColor color;

  Tile(this.value, this.color);
}

class TileWidget extends StatelessWidget {
  final Tile tile;

  const TileWidget({required this.tile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50, // Задайте размер плитки в соответствии с вашим дизайном
      height: 50,
      color: tile.color,
      child: Center(
        child: Text(
          tile.value.toString(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}