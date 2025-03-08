import 'package:flutter/material.dart';
import 'game_button.dart';

class GameButtonGrid extends StatelessWidget {
  final List<GameButtonData> buttons;

  const GameButtonGrid({super.key, required this.buttons});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      padding: const EdgeInsets.all(20),
      children: buttons.map((button) => GameButton(data: button)).toList(),
    );
  }
}
