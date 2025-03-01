import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NPButton extends ConsumerWidget{
  final void Function() onPressed;
  final Widget? child;

  const NPButton({super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }

}