import 'package:flutter/material.dart';
import 'package:my_reading_game/widgets/game_background.dart';
import 'package:my_reading_game/widgets/level_coin_display.dart';
import 'package:my_reading_game/widgets/game_button_grid.dart';
import 'package:my_reading_game/widgets/game_button.dart';
import 'package:my_reading_game/widgets/mute_button.dart';
import 'package:my_reading_game/ui/laslaxa_screen.dart';
import 'package:my_reading_game/ui/alphabet_selection_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;

class GameScreen extends StatefulWidget {
  final String playerName;

  const GameScreen({super.key, required this.playerName});

  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  int level = 1;
  int coins = 0;

  @override
  void initState() {
    super.initState();
    _loadGameData();
  }

  Future<void> _saveGameData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(
      '${directory.path}/${widget.playerName.toLowerCase()}_save.json',
    );

    final gameData = {"level": level, "coins": coins};

    await file.writeAsString(jsonEncode(gameData));
    developer.log("Data sparad för ${widget.playerName}: $gameData");

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Sparat!")));
    }
  }

  Future<void> _loadGameData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(
      '${directory.path}/${widget.playerName.toLowerCase()}_save.json',
    );

    if (await file.exists()) {
      final data = jsonDecode(await file.readAsString());
      setState(() {
        level = data["level"] ?? 1;
        coins = data["coins"] ?? 0;
      });
      developer.log("Data laddad för ${widget.playerName}: $data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Välj ett spel, ${widget.playerName}"),
        backgroundColor: Colors.brown,
      ),
      body: Stack(
        children: [
          const GameBackground(),
          Column(
            children: [
              LevelCoinDisplay(level: level, coins: coins),
              Expanded(
                child: GameButtonGrid(
                  buttons: [
                    GameButtonData(
                      title: "Läsläxa",
                      imagePath: "assets/images/läsläxa.png",
                      destination: const LaslaxaScreen(),
                    ),
                    GameButtonData(
                      title: "Förståelse",
                      imagePath: "assets/images/förståelse.png",
                      destination: null, // lägg till senare
                    ),
                    GameButtonData(
                      title: "Skriva",
                      imagePath: "assets/images/skriva.png",
                      destination: null, // lägg till senare
                    ),
                    GameButtonData(
                      title: "Alfabet",
                      imagePath: "assets/images/alfabet.png",
                      destination: const AlphabetGameSelectionScreen(),
                    ),
                    GameButtonData(
                      title: "Para ihop",
                      imagePath: "assets/images/para_ihop.png",
                      destination: null, // lägg till senare
                    ),
                    GameButtonData(
                      title: "Ord",
                      imagePath: "assets/images/ord.png",
                      destination: null, // lägg till senare
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton(
              onPressed: _saveGameData,
              child: const Text("Spara"),
            ),
          ),
          Positioned(top: 20, right: 20, child: const MuteButton()),
        ],
      ),
    );
  }
}
