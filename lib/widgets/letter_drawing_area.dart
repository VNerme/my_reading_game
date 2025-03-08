import 'package:flutter/material.dart';
import 'letter_painter.dart';

class LetterDrawingArea extends StatelessWidget {
  final List<Offset> points;
  final void Function(Offset localPosition) onDrawingUpdate;
  final VoidCallback onDrawingEnd;

  const LetterDrawingArea({
    super.key,
    required this.points,
    required this.onDrawingUpdate,
    required this.onDrawingEnd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final Offset localPosition = renderBox.globalToLocal(
          details.globalPosition,
        );
        onDrawingUpdate(localPosition);
      },
      onPanEnd: (details) => onDrawingEnd(),
      child: SizedBox.expand(
        child: CustomPaint(painter: LetterPainter(points)),
      ),
    );
  }
}
