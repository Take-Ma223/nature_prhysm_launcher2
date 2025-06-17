import 'package:flutter/material.dart';
import '../component/NPCard.dart';
import '../component/NPText.dart';

/// 複数の設定項目をグループにまとめて表示するUI
class SettingGroupCard extends StatelessWidget {
  final String title;
  final Widget child;

  const SettingGroupCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(width: 20),
            NPText(text: title, style: TextStyle(fontSize: 28))
          ],
        ),
        NPCard(
          child: Padding(padding: EdgeInsets.all(20) ,child: child)
        )
      ],
    );
  }
}