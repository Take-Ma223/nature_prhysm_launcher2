import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:win32/win32.dart';
import 'dart:collection';
import 'dart:ffi';
import 'package:ffi/ffi.dart';

final asioDriverProvider = Provider.autoDispose(
        (ref){
      return AsioFFI().getAsioDrivers();
    }
);

class AsioFFI {
  late final DynamicLibrary _asioLib;
  late final Pointer<Utf8> Function() _getAsioDriverNames;
  late final void Function(Pointer<Utf8>) _freeMemory;

  AsioFFI() {
    // C# の DLL をロード
    _asioLib = DynamicLibrary.open("./programs/launcher/dll/AsioLibrary.dll");

    _getAsioDriverNames = _asioLib
        .lookupFunction<Pointer<Utf8> Function(), Pointer<Utf8> Function()>(
        "GetAsioDriverNames");

    _freeMemory = _asioLib
        .lookupFunction<Void Function(Pointer<Utf8>), void Function(Pointer<Utf8>)>(
        "FreeMemory");
  }

  List<String> getAsioDrivers() {
    final ptr = _getAsioDriverNames();
    if (ptr == nullptr) {
      return [];
    }

    final driverList = ptr.toDartString().split("\n");

    // メモリ解放
    _freeMemory(ptr);

    return driverList;
  }
}