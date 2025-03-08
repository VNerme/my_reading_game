import 'package:flutter/material.dart';

class PlaceholderIcon extends StatelessWidget {
  final String imagePath;

  const PlaceholderIcon({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.1,
      opacity: const AlwaysStoppedAnimation(0.5),
    );
  }
}
