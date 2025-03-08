import 'package:flutter/material.dart';

class LevelCoinDisplay extends StatelessWidget {
  final int level;
  final int coins;

  const LevelCoinDisplay({super.key, required this.level, required this.coins});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        "Level: $level | Mynt: $coins",
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
