import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NPCheckbox extends ConsumerWidget{
  final bool value;
  final void Function(bool?) onChanged;

  const NPCheckbox({super.key, required this.value, required this.onChanged});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      fillColor: WidgetStateProperty.resolveWith((states) {
        if(states.contains(WidgetState.selected)){
          return Colors.blue;
        }
        return Colors.white;
      }),
      side: const BorderSide(width: 3.0, color: Colors.blue),
    );
  }

}