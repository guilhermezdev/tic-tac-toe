import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late String currentPlayer;

  late List<String?> gameState;

  late bool isGameOn;

  late String gameStateMessage;

  @override
  void initState() {
    super.initState();
    restart();
  }

  void changePlayer() {
    if (currentPlayer == 'X') {
      currentPlayer = 'O';
    } else {
      currentPlayer = 'X';
    }

    setState(() {
      currentPlayer;
      gameState;
    });
  }

  void makeMove(int index) {
    gameState[index] = currentPlayer;
    if (checkWin(currentPlayer)) {
      showWinner();
    } else if (checkDraw()) {
      showDraw();
    } else {
      changePlayer();
    }
  }

  void restart() {
    setState(() {
      currentPlayer = 'X';
      gameState = List.filled(9, null);
      isGameOn = true;
      gameStateMessage = '';
    });
  }

  bool checkDraw() {
    if (gameState.any((element) => element == null)) {
      return false;
    }
    return true;
  }

  void showWinner() {
    setState(() {
      isGameOn = false;
      gameStateMessage = '$currentPlayer is the Winner!';
    });
  }

  void showDraw() {
    setState(() {
      isGameOn = false;
      gameStateMessage = 'The game ended in draw!';
    });
  }

  bool checkWin(String player) {
    // check horizontals
    if (gameState[0] == player &&
        gameState[1] == player &&
        gameState[2] == player) {
      return true;
    }
    if (gameState[3] == player &&
        gameState[4] == player &&
        gameState[5] == player) {
      return true;
    }

    if (gameState[6] == player &&
        gameState[7] == player &&
        gameState[8] == player) {
      return true;
    }

    // check verticals

    if (gameState[0] == player &&
        gameState[3] == player &&
        gameState[6] == player) {
      return true;
    }

    if (gameState[1] == player &&
        gameState[4] == player &&
        gameState[7] == player) {
      return true;
    }

    if (gameState[2] == player &&
        gameState[5] == player &&
        gameState[8] == player) {
      return true;
    }

    // check diagonals

    if (gameState[2] == player &&
        gameState[4] == player &&
        gameState[6] == player) {
      return true;
    }

    if (gameState[0] == player &&
        gameState[4] == player &&
        gameState[8] == player) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 32.0,
            ),
            const Center(
              child: Text(
                'TIC TAC TOE',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            Center(
              child: Text(
                'TURN: $currentPlayer',
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: gameState
                      .mapIndexed(
                        (index, value) => BoardCell(
                          value: value,
                          onTap: () {
                            if (isGameOn && value == null) {
                              makeMove(index);
                            }
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            if (gameStateMessage.isNotEmpty)
              Text(
                gameStateMessage,
                style: const TextStyle(color: Colors.black),
              ),
            ElevatedButton(
              onPressed: restart,
              child: const Text('Restart'),
            )
          ],
        ),
      ),
    );
  }
}

class BoardCell extends StatelessWidget {
  final String? value;
  final VoidCallback onTap;

  const BoardCell({
    super.key,
    this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2.0),
        ),
        child: value != null
            ? Center(
                child: Text(
                  value!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 32.0,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
