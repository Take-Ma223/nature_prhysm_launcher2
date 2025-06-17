import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:win32/win32.dart';
import 'dart:collection';
import 'dart:ffi';
import 'package:ffi/ffi.dart';

final fontNameListProvider = FutureProvider(
    (ref){
      return fetchFontsNameList();
    }
);

/// インストール済みフォントの取得
Future<List<String>> fetchFontsNameList() async {
  final hDC = GetDC(NULL);
  final searchFont = calloc<LOGFONT>()..ref.lfCharSet = ANSI_CHARSET;

  final fontNames = SplayTreeSet<String>();

  int enumerateFonts(
      Pointer<LOGFONT> logFont,
      Pointer<TEXTMETRIC> _,
      int __,
      int ___,
      ) {
    // Get extended information from the font
    final logFontEx = logFont.cast<ENUMLOGFONTEX>();
    final elfFullName = logFontEx.ref.elfFullName;

    //縦書きフォントは無視する
    if(elfFullName[0] != '@'){
      fontNames.add(logFontEx.ref.elfFullName);
    }
    return TRUE; // continue enumeration
  }

  final lpProc = NativeCallable<FONTENUMPROC>.isolateLocal(
    enumerateFonts,
    exceptionalReturn: 0,
  );

  //インストール済みフォント情報を取得
  EnumFontFamiliesEx(hDC, searchFont, lpProc.nativeFunction, 0, 0);
  lpProc.close();

  print('${fontNames.length} font families discovered.');
  for (final font in fontNames) {
    //print(font);
  }
  free(searchFont);
  return fontNames.toList();
}