import 'package:flutter/material.dart';

class DescAndSettingItem extends StatelessWidget {
  final Widget desc;
  final Widget settingItem;

  const DescAndSettingItem({
    super.key,
    required this.desc,
    required this.settingItem,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [desc, settingItem],
    );
  }
}
