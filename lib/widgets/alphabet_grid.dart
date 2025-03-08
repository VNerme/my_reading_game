import 'package:flutter/material.dart';
import 'package:my_reading_game/data/swedish_alphabet.dart';

class AlphabetGrid extends StatelessWidget {
  final Function(String) onLetterSelected;

  const AlphabetGrid({super.key, required this.onLetterSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 1.0,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: swedishAlphabet.length,
        itemBuilder: (context, index) {
          String letter = swedishAlphabet[index];
          return AlphabetLetterTile(
            letter: letter,
            onTap: () => onLetterSelected(letter),
          );
        },
      ),
    );
  }
}

class AlphabetLetterTile extends StatelessWidget {
  final String letter;
  final VoidCallback onTap;

  const AlphabetLetterTile({
    super.key,
    required this.letter,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(204, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          letter,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
