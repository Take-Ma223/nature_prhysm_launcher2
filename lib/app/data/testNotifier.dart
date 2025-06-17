// StateNotifierProvider
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterStateNotifierProvider = StateNotifierProvider<CounterStateNotifier, int>((ref) {
  return CounterStateNotifier();
});

class CounterStateNotifier extends StateNotifier<int> {
  CounterStateNotifier() : super(0);

  void increment() => state++;
}


