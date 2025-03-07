import 'package:flutter/material.dart';
import 'package:my_reading_game/ui/alphabet_game_screen.dart';
import 'package:my_reading_game/constants/alph_const.dart'; // Se till att rätt import används

class AlphabetGameSelectionScreen extends StatefulWidget {
  const AlphabetGameSelectionScreen({super.key});

  @override
  AlphabetGameSelectionScreenState createState() =>
      AlphabetGameSelectionScreenState();
}

class AlphabetGameSelectionScreenState
    extends State<AlphabetGameSelectionScreen> {
  bool isMuted = false; // För mute-knappen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Bakgrundsbild
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/alfabet/alph_bak.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // GridView för alla bokstäver
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, // Antal bokstäver per rad
                childAspectRatio: 1.0,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: swedishAlphabet.length,
              itemBuilder: (context, index) {
                String? letter = swedishAlphabet[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                AlphabetGameScreen(selectedLetter: letter),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        204,
                        255,
                        255,
                        255,
                      ), // Fixat deprecated `withOpacity`
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      letter,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Mute-knapp
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: Icon(
                isMuted ? Icons.volume_off : Icons.volume_up,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  isMuted = !isMuted;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
