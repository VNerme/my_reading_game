import 'package:flame_audio/flame_audio.dart';

class MusicController {
  static final MusicController _instance = MusicController._internal();
  factory MusicController() => _instance;
  MusicController._internal();

  bool isMuted = false;
  int currentTrackIndex = 0; // Håller koll på vilken låt som spelas

  final List<String> playlist = [
    '01OneSummersDay.mp3',
    '02MysticalForest.mp3',
    '03AdventureBegins.mp3',
  ];

  // Starta musiken
  Future<void> playMusic({bool restart = false}) async {
    if (!isMuted) {
      if (restart) {
        stopMusic(); // Stoppa och starta om
      }
      FlameAudio.bgm.play(playlist[currentTrackIndex], volume: 1);
    }
  }

  // Stoppa musiken
  void stopMusic() {
    FlameAudio.bgm.stop();
  }

  // Växla mute-status
  void toggleMute() {
    isMuted = !isMuted;
    if (isMuted) {
      stopMusic();
    } else {
      playMusic(restart: false); // Starta om musiken vid mute-off
    }
  }

  // Byt till nästa låt
  void nextTrack() {
    currentTrackIndex = (currentTrackIndex + 1) % playlist.length;
    playMusic(restart: true);
  }

  // Byt till föregående låt
  void previousTrack() {
    currentTrackIndex = (currentTrackIndex - 1) % playlist.length;
    if (currentTrackIndex < 0) {
      currentTrackIndex = playlist.length - 1;
    }
    playMusic(restart: true);
  }
}
