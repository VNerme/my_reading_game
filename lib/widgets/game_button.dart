import 'package:flutter/material.dart';

class GameButtonData {
  final String title;
  final String imagePath;
  final Widget? destination;

  GameButtonData({
    required this.title,
    required this.imagePath,
    this.destination,
  });
}

class GameButton extends StatelessWidget {
  final GameButtonData data;

  const GameButton({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
          data.destination != null
              ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => data.destination!),
                );
              }
              : null,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Image.asset(data.imagePath, fit: BoxFit.cover)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
