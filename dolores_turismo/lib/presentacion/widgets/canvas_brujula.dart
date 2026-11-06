import 'dart:math' as math;
import 'package:flutter/material.dart';

class CanvasBrujula extends StatelessWidget {
  final double rumbo;
  const CanvasBrujula({super.key, required this.rumbo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black45),
      child: Transform.rotate(
        angle: -rumbo * math.pi / 180,
        child: CustomPaint(painter: _PintorBrujula()),
      ),
    );
  }
}

class _PintorBrujula extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centro = size.center(Offset.zero);
    final lapizNorte = Paint()..color = Colors.redAccent..style = PaintingStyle.fill;
    final lapizSur = Paint()..color = Colors.white70..style = PaintingStyle.fill;

    final norte = Path()
      ..moveTo(centro.dx, 4)
      ..lineTo(centro.dx - 6, centro.dy)
      ..lineTo(centro.dx + 6, centro.dy)
      ..close();

    final sur = Path()
      ..moveTo(centro.dx, size.height - 4)
      ..lineTo(centro.dx - 6, centro.dy)
      ..lineTo(centro.dx + 6, centro.dy)
      ..close();

    canvas.drawPath(norte, lapizNorte);
    canvas.drawPath(sur, lapizSur);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}