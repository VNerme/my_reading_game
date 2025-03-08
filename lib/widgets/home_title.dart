import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTitle extends StatelessWidget {
  final String title;

  const HomeTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.pacifico(
        fontSize: MediaQuery.of(context).size.width * 0.07,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
