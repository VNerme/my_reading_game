import 'package:flutter/material.dart';
import 'package:my_reading_game/widgets/mute_button.dart';

class MuteButtonState extends State<MuteButton> {
  bool isMuted = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
      onPressed: () {
        setState(() {
          isMuted = !isMuted;
        });
      },
    );
  }
}
