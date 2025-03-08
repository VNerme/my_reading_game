import 'package:flutter/material.dart';
import 'package:my_reading_game/widgets/home_background.dart';
import 'package:my_reading_game/widgets/home_title.dart';
import 'package:my_reading_game/utils/music_controller.dart';
import 'package:my_reading_game/widgets/player_icon_button.dart';
import 'package:my_reading_game/widgets/placeholder_icon.dart';
import 'package:my_reading_game/widgets/mute_button.dart';
import 'package:my_reading_game/ui/game_screen.dart';
import 'package:flame_audio/flame_audio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final MusicController musicController = MusicController();

  @override
  void initState() {
    super.initState();
    FlameAudio.audioCache.load('button_click.mp3');
    if (!musicController.isPlaying) {
      musicController.playMusic();
    }
  }

  void _playClickSound() {
    FlameAudio.play('button_click.mp3');
  }

  void _navigateToGame(String playerName) {
    _playClickSound();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(playerName: playerName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const HomeBackground(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const HomeTitle(title: "Välj spelare"),
                const SizedBox(height: 20),
                PlayerIconButton(
                  playerName: "Leo",
                  imagePath: "assets/images/icons/Leo_icon.png",
                  onTap: () => _navigateToGame("Leo"),
                ),
                const SizedBox(height: 15),
                PlayerIconButton(
                  playerName: "Max",
                  imagePath: "assets/images/icons/Max_icon.png",
                  onTap: () => _navigateToGame("Max"),
                ),
                const SizedBox(height: 20),
                const PlaceholderIcon(
                  imagePath: "assets/images/icons/spela_icon.png",
                ),
                const SizedBox(height: 20),
                const PlaceholderIcon(
                  imagePath: "assets/images/icons/folder.png",
                ),
              ],
            ),
          ),
          Positioned(bottom: 20, right: 20, child: const MuteButton()),
        ],
      ),
    );
  }
}
