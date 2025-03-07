import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:my_reading_game/ui/alphabet_game_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:my_reading_game/ui/laslaxa_screen.dart';
import '../widgets/mute_button.dart';

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
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File(
        '${directory.path}/${widget.playerName.toLowerCase()}_save.json',
      );

      Map<String, dynamic> gameData = {"level": level, "coins": coins};

      await file.writeAsString(jsonEncode(gameData));

      developer.log("Data sparad för ${widget.playerName}: $gameData");

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Sparat!")));
      }
    } catch (e) {
      developer.log("Fel vid sparande: $e");
    }
  }

  Future<void> _loadGameData() async {
    try {
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
      } else {
        developer.log(
          "Ingen sparfil hittad för ${widget.playerName}, skapar ny.",
        );
      }
    } catch (e) {
      developer.log("Fel vid laddning: $e");
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
          // Bakgrund och spelknappar
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/game_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Level: $level | Mynt: $coins",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    padding: const EdgeInsets.all(20),
                    children: [
                      _buildGameButton(
                        context,
                        "Läsläxa",
                        "assets/images/läsläxa.png",
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LaslaxaScreen(),
                            ),
                          );
                        },
                      ),
                      _buildGameButton(
                        context,
                        "Förståelse",
                        "assets/images/förståelse.png",
                        () {
                          // Lägg till navigation här
                        },
                      ),
                      _buildGameButton(
                        context,
                        "Skriva",
                        "assets/images/skriva.png",
                        () {
                          // Lägg till navigation här
                        },
                      ),
                      _buildGameButton(
                        context,
                        "Alfabet",
                        "assets/images/alfabet.png",
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      AlphabetGameScreen(selectedLetter: ''),
                            ),
                          );
                        },
                      ),
                      _buildGameButton(
                        context,
                        "Para ihop",
                        "assets/images/para_ihop.png",
                        () {
                          // Lägg till navigation här
                        },
                      ),
                      _buildGameButton(
                        context,
                        "Ord",
                        "assets/images/ord.png",
                        () {
                          // Lägg till navigation här
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Spara-knapp längst ner till vänster
          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton(
              onPressed: _saveGameData,
              child: const Text("Spara"),
            ),
          ),
          // Mute-knappen längst ner till höger
          Positioned(bottom: 20, right: 20, child: MuteButton()),
        ],
      ),
    );
  }

  Widget _buildGameButton(
    BuildContext context,
    String title,
    String imagePath,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Image.asset(imagePath, fit: BoxFit.cover)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
