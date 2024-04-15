import 'package:flutter/material.dart';
import 'package:game_2048/data/colors.dart';

class EmptyTile extends StatelessWidget {
  final double size;

  const EmptyTile({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: lightBrown,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
