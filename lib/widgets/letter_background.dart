import 'package:flutter/material.dart';
import 'package:my_reading_game/data/swedish_alphabet.dart';

class LetterBackground extends StatelessWidget {
  final String letter;

  const LetterBackground({super.key, required this.letter});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(letterImages[letter] ?? letterImages["A"]!),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
