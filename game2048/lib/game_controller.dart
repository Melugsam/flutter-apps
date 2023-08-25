import 'package:flutter/material.dart';
import 'direction.dart';
import 'tile.dart';

class GameController extends StatefulWidget {
  final int size;
  
  GameController({Key? key, required this.size,}) : super(key: key);

  @override
  State<GameController> createState() => _GameControllerState();
}

class _GameControllerState extends State<GameController> {
  late List<List<Tile>> tiles;

  @override
  void initState() {
    super.initState();
    tiles = List.generate(widget.size, (_) => List<Tile>.filled(widget.size, Tile(0, Colors.lightBlue)));
  }

  void startNewGame() {
    // Логика начала новой игры
  }

  void swipe(Direction direction) {
    // Обработка свайпа в указанном направлении
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 500,
      color: Colors.red,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.size, // Количество столбцов в сетке
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0
        ),
        itemCount: widget.size*widget.size,
        itemBuilder: (BuildContext context, int index) {
          Tile tile = Tile(index,Colors.amber);
          return TileWidget(tile: tile);
        },
      ),
    );
  }
}
