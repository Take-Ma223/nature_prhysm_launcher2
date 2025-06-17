import 'package:flutter/material.dart';

class  NPDropDownButton<T> extends StatelessWidget{
  final double width;
  final bool isExpanded;
  final T value;
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?) onChanged;

  const NPDropDownButton({
    super.key,
    required this.width,
    required this.isExpanded,
    required this.value,
    required this.items,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: DropdownButton<T>(
        isExpanded: isExpanded,
        value: value,
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}