import 'package:flutter/material.dart';

class AlphabetBackground extends StatelessWidget {
  const AlphabetBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/alfabet/alph_bak.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
