import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_reading_game/widgets/letter_background.dart';
import 'package:my_reading_game/widgets/semi_transparent_letter.dart';
import 'package:my_reading_game/widgets/letter_drawing_area.dart';
import 'package:my_reading_game/data/swedish_alphabet.dart';
import 'package:my_reading_game/widgets/mute_button.dart'; // Added import

class AlphabetGameScreen extends StatefulWidget {
  final String selectedLetter;

  const AlphabetGameScreen({super.key, required this.selectedLetter});

  @override
  AlphabetGameScreenState createState() => AlphabetGameScreenState();
}

class AlphabetGameScreenState extends State<AlphabetGameScreen> {
  final List<Offset> points = [];
  late String currentLetter;
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    currentLetter = widget.selectedLetter;
    _loadSavedLetter();
  }

  Future<void> _saveCurrentLetter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("savedLetter", currentLetter);
  }

  Future<void> _loadSavedLetter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentLetter = prefs.getString("savedLetter") ?? widget.selectedLetter;
    });
  }

  void _clearDrawing() {
    setState(() {
      points.clear();
    });
  }

  void _nextLetter() async {
    List<String> letters = letterImages.keys.toList();
    int currentIndex = letters.indexOf(currentLetter);
    if (currentIndex < letters.length - 1) {
      setState(() {
        currentLetter = letters[currentIndex + 1];
        _clearDrawing();
      });

      await _saveCurrentLetter();
      await flutterTts.speak(currentLetter);
    }
  }

  void _resetProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("savedLetter");
    setState(() {
      currentLetter = "A";
      _clearDrawing();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _resetProgress,
            child: const Text(
              "Återställ",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          LetterBackground(letter: currentLetter),
          SemiTransparentLetter(letter: currentLetter),
          LetterDrawingArea(
            points: points,
            onDrawingUpdate: (Offset localPosition) {
              setState(() {
                if (_pointsCondition(localPosition)) {
                  points.add(localPosition);
                }
              });
            },
            onDrawingEnd: () async {
              if (points.length > 20) {
                await flutterTts.speak(currentLetter);
                _nextLetter();
              }
            },
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: const MuteButton(),
          ), // Added MuteButton her),
        ],
      ),
    );
  }

  bool _pointsCondition(Offset localPosition) {
    return points.isEmpty || (localPosition - points.last).distance > 5;
  }
}
