import 'dart:math';
import 'package:flutter/material.dart';

class CircularWaterQualityContainer extends StatelessWidget {
  final double percentage;

  const CircularWaterQualityContainer({
    super.key,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: CustomPaint(
        size: const Size(150, 150),
        painter: CircularWaterQualityPainter(percentage: percentage),
      ),
    );
  }
}

class CircularWaterQualityPainter extends CustomPainter {
  final double percentage;

  CircularWaterQualityPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    Paint bgPaint = Paint()
      ..color = Colors.grey
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    Paint fgPaint = Paint()
      ..color = const Color.fromARGB(255, 33, 54, 243)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    Paint dottedLinePaint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2;

    // Draw dotted lines
    for (int i = 0; i < 360; i += 20) {
      double startX = center.dx + radius * cos(i * pi / 180);
      double startY = center.dy + radius * sin(i * pi / 180);
      double endX = center.dx + (radius + 20) * cos(i * pi / 180);
      double endY = center.dy + (radius + 20) * sin(i * pi / 180);
      canvas.drawLine(
          Offset(startX, startY), Offset(endX, endY), dottedLinePaint);
    }

    canvas.drawCircle(center, radius, bgPaint);

    double sweepAngle = 2 * pi * (percentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      fgPaint,
    );

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: '${percentage.toStringAsFixed(1)}%',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width);

    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2,
          center.dy - textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
