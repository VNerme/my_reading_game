import 'package:flutter/material.dart';

class PlayerIconButton extends StatelessWidget {
  final String playerName;
  final String imagePath;
  final VoidCallback onTap;

  const PlayerIconButton({
    super.key,
    required this.playerName,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        imagePath,
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.15,
      ),
    );
  }
}
