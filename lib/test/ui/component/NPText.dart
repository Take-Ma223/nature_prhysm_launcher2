import 'package:flutter/material.dart';

class NPText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const NPText({
    super.key,
    required this.text,
    this.style = const TextStyle(fontSize: 16)
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}