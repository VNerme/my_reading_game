import 'package:flutter/material.dart';
import 'package:my_reading_game/widgets/alphabet_background.dart';
import 'package:my_reading_game/widgets/alphabet_grid.dart';
import 'package:my_reading_game/widgets/mute_button.dart';
import 'package:my_reading_game/utils/music_controller.dart';
import 'package:my_reading_game/ui/alphabet_game_screen.dart';

class AlphabetGameSelectionScreen extends StatefulWidget {
  const AlphabetGameSelectionScreen({super.key});

  @override
  AlphabetGameSelectionScreenState createState() =>
      AlphabetGameSelectionScreenState();
}

class AlphabetGameSelectionScreenState
    extends State<AlphabetGameSelectionScreen> {
  final MusicController musicController = MusicController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          const AlphabetBackground(),
          AlphabetGrid(
            onLetterSelected: (String letter) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => AlphabetGameScreen(selectedLetter: letter),
                ),
              );
            },
          ),
          Positioned(top: 20, right: 20, child: const MuteButton()),
        ],
      ),
    );
  }
}
