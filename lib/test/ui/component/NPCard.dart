import 'package:flutter/material.dart';

class NPCard extends StatelessWidget{
  final Widget child;

  const NPCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // 影の高さ
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // 角丸
      ),
      child: child,
    );
  }
  
  
}