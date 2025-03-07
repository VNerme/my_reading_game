import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Nu används korrekt
import 'package:my_reading_game/ui/letter_painter.dart';
import 'package:my_reading_game/constants/alph_const.dart'; // Uppdaterad import

class AlphabetGameScreen extends StatefulWidget {
  final String selectedLetter;

  const AlphabetGameScreen({super.key, required this.selectedLetter});

  @override
  AlphabetGameScreenState createState() => AlphabetGameScreenState();
}

class AlphabetGameScreenState extends State<AlphabetGameScreen> {
  final List<Offset> _points = [];
  late String currentLetter;
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    currentLetter = widget.selectedLetter; // Sätt ett initialt värde
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
      _points.clear();
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

      await _saveCurrentLetter(); // Spara bokstaven här
      await flutterTts.speak(currentLetter);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Current letter: $currentLetter");
    double screenHeight = MediaQuery.of(context).size.height;
    double fontSize = screenHeight * 0.5;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove("savedLetter"); // Raderar sparad bokstav
              setState(() {
                currentLetter = "A"; // Startar om från A
                _clearDrawing();
              });
            },
            child: Text(
              "Återställ",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Dynamisk bakgrundsbild baserat på vald bokstav
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    letterImages[currentLetter] ?? letterImages["A"]!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Halvgenomskinlig bokstav i mitten
          Center(
            child: Opacity(
              opacity: 0.3,
              child: Text(
                currentLetter,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // Ritningsområde
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                RenderBox object = context.findRenderObject() as RenderBox;
                Offset localPosition = object.globalToLocal(
                  details.globalPosition,
                );

                if (_isInsideLetterShape(localPosition)) {
                  if (_points.isEmpty ||
                      (localPosition - _points.last).distance > 5) {
                    _points.add(localPosition);
                  }
                }
              });
            },
            onPanEnd: (details) async {
              if (_points.length > 20) {
                await flutterTts.speak(currentLetter);
                _nextLetter();
              }
            },
            child: SizedBox.expand(
              child: CustomPaint(painter: LetterPainter(_points)),
            ),
          ),
        ],
      ),
    );
  }

  bool _isInsideLetterShape(Offset point) {
    return true; // Ersätt detta med en faktisk formkontroll.
  }
}
