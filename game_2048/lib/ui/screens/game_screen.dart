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
  bool gameLoosed = false;
  final int gridSize = 4;

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
                        onVerticalDragEnd: (details) {
                          if (details.primaryVelocity!.isNegative) {
                            setState(() {
                              moveUp();
                              generateNewTiles(tileSize);
                            });
                          } else {
                            setState(() {
                              moveDown();
                              generateNewTiles(tileSize);
                            });
                          }
                        },
                        onHorizontalDragEnd: (details) {
                          if (details.primaryVelocity!.isNegative) {
                            setState(() {
                              moveRight();
                              generateNewTiles(tileSize);
                            });
                          } else {
                            setState(() {
                              moveLeft();
                              generateNewTiles(tileSize);
                            });
                          }
                        },
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
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
                      child: IconButton(
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
                      ),
                    ),
                    Visibility(
                      visible: gameLoosed,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            gameLoosed = !gameLoosed;
                            startNewGame(tileSize);
                          });
                        },
                        icon: Center(
                          child: Column(
                            children: [
                              Text(
                                "Ты проиграл",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: tileSize / 3),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    gameLoosed = !gameLoosed;
                                    startNewGame(tileSize);
                                  });
                                },
                                child: const Text(
                                  "Ещё раз",
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ),
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
    // for (int i = 0; i < gridSize; i++) {
    //   tiles.add(List<int>.filled(gridSize, 2));
    // }
  }

  void generateNewTiles(double tileSize) {
    Random random = Random();
    for (int i = 0; i < 2; i++) {
      int row, column;
      do {
        row = random.nextInt(gridSize);
        column = random.nextInt(gridSize);
      } while (tiles[row][column] != 0 && check());
      int value = (random.nextDouble() < 0.9) ? 2 : 4;
      tiles[row][column] = value;
    }
  }

  bool check() {
    int num=0;
    for (int row=0; row<tiles.length; row++){
      for (int column=0; column<tiles[row].length; column++){
        if (tiles[row][column]==0) num++;
        if (num>=2) return true;
      }
    }
    return false;
  }

  void moveUp() {
    for (int column = 0; column < tiles.length; column++) {
      List<int> tempList = [];
      for (int row = 0; row < tiles[column].length; row++) {
        tempList.add(tiles[row][column]);
      }
      List<int> newList = updateRow(tempList.reversed.toList());
      for (int row = 0; row < tiles[column].length; row++) {
        tiles[row][column] = newList[tiles[column].length - row - 1];
      }
    }
  }

  void moveDown() {
    for (int column = 0; column < tiles.length; column++) {
      List<int> tempList = [];
      for (int row = 0; row < tiles[column].length; row++) {
        tempList.add(tiles[row][column]);
      }
      List<int> newList = updateRow(tempList);
      for (int row = 0; row < tiles[column].length; row++) {
        tiles[row][column] = newList[row];
      }
    }
  }

  void moveRight() {
    for (int row = 0; row < tiles.length; row++) {
      tiles[row] = updateRow(tiles[row].reversed.toList()).reversed.toList();
    }
  }

  void moveLeft() {
    for (int row = 0; row < tiles.length; row++) {
      tiles[row] = updateRow(tiles[row]);
    }
  }

  List<int> updateRow(List<int> row) {
    for (int column = 1; column < row.length; column++) {
      int tempIndex = row.length - 1;
      while (tempIndex != 0) {
        int curr = row[tempIndex];
        int prev = row[tempIndex - 1];
        if (curr > 0 && curr == prev) {
          row[tempIndex - 1] = row[tempIndex - 1] * 2;
          row[tempIndex] = 0;
        }
        if (curr > 0 && prev == 0) {
          row[tempIndex - 1] = curr;
          row[tempIndex] = 0;
          tempIndex = row.length - 1;
        }
        tempIndex--;
      }
    }
    return row;
  }
}
