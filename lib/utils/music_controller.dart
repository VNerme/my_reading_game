import 'package:flame_audio/flame_audio.dart';

class MusicController {
  static final MusicController _instance = MusicController._internal();
  factory MusicController() => _instance;
  MusicController._internal();

  bool isMuted = false;
  bool isPlaying = false; // Track if music is playing
  int currentTrackIndex = 0;

  final List<String> playlist = [
    '01OneSummersDay.mp3',
    '02MysticalForest.mp3',
    '03AdventureBegins.mp3',
  ];

  // Start or resume music
  Future<void> playMusic({bool restart = false}) async {
    if (!isMuted) {
      if (restart) {
        await FlameAudio.bgm.stop();
      }
      await FlameAudio.bgm.play(playlist[currentTrackIndex], volume: 1);
      isPlaying = true;
    }
  }

  // Pause music
  Future<void> pauseMusic() async {
    if (isPlaying) {
      await FlameAudio.bgm.pause();
      isPlaying = false;
    }
  }

  // Resume music only if it was playing before
  Future<void> resumeMusic() async {
    if (!isMuted && !isPlaying) {
      await FlameAudio.bgm.resume();
      isPlaying = true;
    }
  }

  // Toggle mute without restarting the track
  Future<void> toggleMute() async {
    isMuted = !isMuted;
    if (isMuted) {
      await pauseMusic();
    } else {
      await resumeMusic();
    }
  }

  // Next track
  Future<void> nextTrack() async {
    currentTrackIndex = (currentTrackIndex + 1) % playlist.length;
    await playMusic(restart: true);
  }

  // Previous track
  Future<void> previousTrack() async {
    currentTrackIndex = (currentTrackIndex - 1) % playlist.length;
    if (currentTrackIndex < 0) {
      currentTrackIndex = playlist.length - 1;
    }
    await playMusic(restart: true);
  }

  // Stop music completely
  Future<void> stopMusic() async {
    await FlameAudio.bgm.stop();
    isPlaying = false;
  }
}
