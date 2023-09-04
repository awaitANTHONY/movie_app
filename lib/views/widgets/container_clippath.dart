import 'package:flutter/material.dart';

class ContainerClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height * 0.95);
    path.lineTo(size.width, size.height * 0.00);
    path.lineTo(0, size.height * 0.05);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
