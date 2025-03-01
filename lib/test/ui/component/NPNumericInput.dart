import 'package:flutter/cupertino.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class NPNumericInput extends StatelessWidget {
  final int value;
  final int min;
  final int max;
  final void Function(double) onChanged;

  const NPNumericInput({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      child: SpinBox(
        min: min.toDouble(),
        max: max.toDouble(),
        value: value.toDouble(),
        onChanged: onChanged,
      ),
    );
  }
}
