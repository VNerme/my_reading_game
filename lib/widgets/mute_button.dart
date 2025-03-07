import 'package:flutter/material.dart';
import '../utils/music_controller.dart';

// Skapa en global instans (om det inte finns en bättre central hantering)
final MusicController musicController = MusicController();

class MuteButton extends StatefulWidget {
  const MuteButton({super.key});

  @override
  MuteButtonState createState() => MuteButtonState();
}

class MuteButtonState extends State<MuteButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        musicController.isMuted
            ? 'assets/images/icons/mute_icon.png'
            : 'assets/images/icons/sound_icon.png',
        width: 50,
        height: 50,
      ),
      onPressed: () {
        setState(() {
          musicController.toggleMute();
        });
      },
    );
  }
}
