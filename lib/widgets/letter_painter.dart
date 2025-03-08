import 'package:flutter/material.dart';

class LetterPainter extends CustomPainter {
  final List<Offset> points;
  LetterPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..color = Colors.blue
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 20.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != Offset.zero && points[i + 1] != Offset.zero) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(LetterPainter oldDelegate) {
    return true;
  }
}
