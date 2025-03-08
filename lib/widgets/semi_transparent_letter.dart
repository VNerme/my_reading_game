import 'package:flutter/material.dart';

class SemiTransparentLetter extends StatelessWidget {
  final String letter;

  const SemiTransparentLetter({super.key, required this.letter});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Text(
        letter,
        style: TextStyle(
          fontSize: screenHeight * 0.5,
          fontWeight: FontWeight.bold,
          color: Colors.black.withOpacity(0.5),
        ),
      ),
    );
  }
}
