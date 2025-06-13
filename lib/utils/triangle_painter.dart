import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final Color color;
  final double rotationAngle; // in degrees

  TrianglePainter({
    required this.color,
    this.rotationAngle = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0) // Top point
      ..lineTo(size.width, size.height) // Bottom right
      ..lineTo(0, size.height) // Bottom left
      ..close();

    canvas.save();
    
    canvas.translate(size.width / 2, size.height / 2);
    
    canvas.rotate(rotationAngle * (3.14159 / 180)); // Convert degrees to radians
    
    canvas.translate(-size.width / 2, -size.height / 2);
    
    canvas.drawPath(path, paint);
    
    canvas.restore();
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => 
    color != oldDelegate.color || rotationAngle != oldDelegate.rotationAngle;
}