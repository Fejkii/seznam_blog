import 'package:flutter/material.dart';

class AppTitleText extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  
  const AppTitleText({
    required this.text,
    super.key,
    this.size = 22,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}