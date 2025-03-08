import 'package:flutter/material.dart';

class GameBackground extends StatelessWidget {
  const GameBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgrounds/game_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
