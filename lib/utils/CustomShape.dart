import 'package:flutter/widgets.dart';

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height / 2.3);
    path.lineTo(size.width / 2.6, size.height / 1.8 - 40);

    var firstControlPoint =
        new Offset(size.width / 1.7 + 20, size.height / 1.8 - 14);
    var firstEndPoint = new Offset(size.width / 1.2 + 60, size.height / 2.4);
    var secondControlPoint =
        new Offset(size.width - (size.width), size.height / 1.8);
    var secondEndPoint = new Offset(size.width, size.height / 2.4);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );
    path.lineTo(size.width, size.height / 3);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
