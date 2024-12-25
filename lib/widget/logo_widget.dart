import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double size;

  LogoWidget({this.size = 100});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.movie, color: Colors.white, size: size);
  }
}
