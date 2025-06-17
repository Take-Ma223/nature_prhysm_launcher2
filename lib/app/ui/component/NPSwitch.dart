import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NPSwitch extends ConsumerWidget{
  final bool value;
  final void Function(bool?) onChanged;

  const NPSwitch({super.key, required this.value, required this.onChanged});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white,
        activeTrackColor: Colors.blue,
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: Colors.grey,
    );
  }

}