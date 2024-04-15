import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_2048/data/colors.dart';
import 'package:game_2048/ui/widgets/core/empty_tile.dart';
import 'package:game_2048/ui/widgets/core/tile.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<List<int>> tiles = [];
  bool gameStarted = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double containerSize = MediaQuery.of(context).size.width - 32.0;
    double tileSize = (containerSize - 4.0 * 2) / 4;
    return Scaffold(
      backgroundColor: tan,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "2048",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        startNewGame(tileSize);
                      });
                    },
                    icon: const Icon(
                      Icons.refresh,
                      size: 36,
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.all(4),
                height: containerSize,
                width: containerSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: darkBrown,
                ),
                child: Stack(
                  children: [
                    if (tiles.isNotEmpty)
                      GestureDetector(
                        onVerticalDragEnd: (details) {},
                        onHorizontalDragEnd: (details) {},
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                          ),
                          itemCount: tiles.length * tiles[0].length,
                          itemBuilder: (context, index) {
                            int row = index ~/ tiles[0].length;
                            int column = index % tiles[0].length;
                            return tiles[row][column] > 0
                                ? Tile(
                                    number: tiles[row][column],
                                    size: tileSize,
                                  )
                                : EmptyTile(size: tileSize);
                          },
                        ),
                      ),
                    Visibility(
                      visible: !gameStarted,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                gameStarted = !gameStarted;
                                startNewGame(tileSize);
                              });
                            },
                            icon: const Center(
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 64,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startNewGame(double tileSize) {
    const int gridSize = 4;
    tiles.clear();

    for (int i = 0; i < gridSize; i++) {
      tiles.add(List<int>.filled(gridSize, 0));
    }

    Random random = Random();
    for (int i = 0; i < 2; i++) {
      int row, column;
      do {
        row = random.nextInt(gridSize);
        column = random.nextInt(gridSize);
      } while (tiles[row][column] != 0);

      int value = (random.nextDouble() < 0.9) ? 2 : 4;

      tiles[row][column] = value;
    }
  }
}
