import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flame_audio/flame_audio.dart'; // För ljud
import 'package:my_reading_game/ui/game_screen.dart';
import 'package:my_reading_game/widgets/mute_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    FlameAudio.audioCache.load('button_click.mp3'); // Ladda ljudfilen i förväg
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Bakgrundsbild
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/home_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Centrera titeln och ikonerna
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Välj spelare",
                  style: GoogleFonts.pacifico(
                    fontSize: screenWidth * 0.07,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),

                // **Leo ikon**
                _buildPlayerIcon("Leo", "assets/images/icons/Leo_icon.png"),

                SizedBox(height: screenHeight * 0.02),

                // **Max ikon**
                _buildPlayerIcon("Max", "assets/images/icons/Max_icon.png"),

                SizedBox(height: screenHeight * 0.02),

                // **Spela placeholder ikon**
                _buildPlaceholderIcon("assets/images/icons/spela_icon.png"),

                SizedBox(height: screenHeight * 0.02),

                // **Folder placeholder ikon**
                _buildPlaceholderIcon("assets/images/icons/folder.png"),
              ],
            ),
          ),
          // Mute-knappen längst ner till höger
          Positioned(bottom: 20, right: 20, child: MuteButton()),
        ],
      ),
    );
  }

  // **Bygger en spelarikon (Leo och Max)**
  Widget _buildPlayerIcon(String playerName, String imagePath) {
    return GestureDetector(
      onTap: () => _navigateToGame(playerName),
      child: Image.asset(
        imagePath,
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.15,
      ),
    );
  }

  // **Bygger en placeholder-ikon (spela och folder)**
  Widget _buildPlaceholderIcon(String imagePath) {
    return Image.asset(
      imagePath,
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.1,
      opacity: const AlwaysStoppedAnimation(
        0.5,
      ), // Gör placeholdern lite genomskinlig
    );
  }
}
