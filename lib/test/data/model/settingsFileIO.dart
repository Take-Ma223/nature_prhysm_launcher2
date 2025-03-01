
import 'dart:convert';
import 'dart:io';

import 'package:charset/charset.dart';
import 'package:nature_prhysm_launcher/test/data/model/settings.dart';
import 'package:win32/win32.dart';

class SettingsFileIO{
  static final Map<String, String> keyToString = {
    "VSYNC": "VSYNC",
    "FPS": "FPS",
    "SHOW_FPS": "SHOW_FPS",

    "SOUND_OUTPUT_TYPE": "SOUND_OUTPUT_TYPE",
    "WASAPI_EXCLUSIVE": "WASAPI_EXCLUSIVE",
    "ASIO_DRIVER": "ASIO_DRIVER",
    "BUFFER": "BUFFER",

    "NOTE_SYMBOL_R": "NOTE_SYMBOL_R",
    "NOTE_SYMBOL_G": "NOTE_SYMBOL_G",
    "NOTE_SYMBOL_B": "NOTE_SYMBOL_B",
    "NOTE_SYMBOL_C": "NOTE_SYMBOL_C",
    "NOTE_SYMBOL_M": "NOTE_SYMBOL_M",
    "NOTE_SYMBOL_Y": "NOTE_SYMBOL_Y",
    "NOTE_SYMBOL_W": "NOTE_SYMBOL_W",
    "NOTE_SYMBOL_K": "NOTE_SYMBOL_K",
    "NOTE_SYMBOL_F": "NOTE_SYMBOL_F",

    "BASE_FONT": "BASE_FONT",

    "VSYNC_OFFSET_COMPENSATION": "VSYNC_OFFSET_COMPENSATION",
    "SHOW_STR_SHADOW": "SHOW_STR_SHADOW",
    "USE_HIPERFORMANCE_TIMER": "USE_HIPERFORMANCE_TIMER",
    "SONG_SELECT_ROW_NUMBER": "SONG_SELECT_ROW_NUMBER",
    "DISPLAY_TIMING_OFFSET": "DISPLAY_TIMING_OFFSET",
    "FULLSCREEN": "FULLSCREEN",
    "EDITABLE": "EDITABLE",
    "USE_AI_PREDICTED_DIFFICULTY": "USE_AI_PREDICTED_DIFFICULTY",

    "SHOW_DEBUG": "SHOW_DEBUG",
    "LOCAL": "LOCAL",
    "USE_PY": "USE_PY",
    "COM_PORT": "COM_PORT",
  };


  /// ファイルから値を読み込む
  /// 読み込み失敗時は例外が返ります
  static Future<Settings> loadSettingData(File file) async {
    print("loadSettingData");
    final stream = await file.readAsBytes();
    final str = utf16.decode(stream);
    final lines = str.split(Platform. lineTerminator);

    int? toInt(String? text) {
      if(text == null)return null;
      return int.parse(text);
    }

    bool? toBool(String? text) {
      if(text == null)return null;

      final value = toInt(text);
      if (value == 1) {
        return true;
      } else {
        return false;
      }
    }

    final Map<String, String> map = {};

    for (String line in lines) {
      final split = line.split(':');
      if (split.length != 2) continue;
      print(split[0] + ":" + split[1]);
      map[split[0]] = split[1];
    }

    var initSettings = Settings.getDefault();

    final List<bool> noteSymbol = [
      toBool(map[keyToString["NOTE_SYMBOL_R"]]) ?? initSettings.noteSymbol[0],
      toBool(map[keyToString["NOTE_SYMBOL_G"]]) ?? initSettings.noteSymbol[1],
      toBool(map[keyToString["NOTE_SYMBOL_B"]]) ?? initSettings.noteSymbol[2],
      toBool(map[keyToString["NOTE_SYMBOL_C"]]) ?? initSettings.noteSymbol[3],
      toBool(map[keyToString["NOTE_SYMBOL_M"]]) ?? initSettings.noteSymbol[4],
      toBool(map[keyToString["NOTE_SYMBOL_Y"]]) ?? initSettings.noteSymbol[5],
      toBool(map[keyToString["NOTE_SYMBOL_W"]]) ?? initSettings.noteSymbol[6],
      toBool(map[keyToString["NOTE_SYMBOL_K"]]) ?? initSettings.noteSymbol[7],
      toBool(map[keyToString["NOTE_SYMBOL_F"]]) ?? initSettings.noteSymbol[8],
    ];





    final result = Settings(
      vsync: toBool(map[keyToString["VSYNC"]]) ?? initSettings.vsync,
      fps: toInt(map[keyToString["FPS"]]) ?? initSettings.fps,
      showFps: toBool(map[keyToString["SHOW_FPS"]]) ?? initSettings.showFps,
      soundOutputType: toInt(map[keyToString["SOUND_OUTPUT_TYPE"]]) ?? initSettings.soundOutputType,
      wasapiExclusive: toBool(map[keyToString["WASAPI_EXCLUSIVE"]]) ?? initSettings.wasapiExclusive,
      asioDriver: toInt(map[keyToString["ASIO_DRIVER"]]) ?? initSettings.asioDriver,
      buffer: toInt(map[keyToString["BUFFER"]]) ?? initSettings.buffer,
      noteSymbol: noteSymbol,
      baseFont: map[keyToString["BASE_FONT"]] ?? initSettings.baseFont,
      vsyncOffsetCompensation: toBool(map[keyToString["VSYNC_OFFSET_COMPENSATION"]]) ?? initSettings.vsyncOffsetCompensation,
      showStrShadow: toBool(map[keyToString["SHOW_STR_SHADOW"]]) ?? initSettings.showStrShadow,
      useHighPerformanceTimer: toBool(map[keyToString["USE_HIPERFORMANCE_TIMER"]]) ?? initSettings.useHighPerformanceTimer,
      songSelectRowNumber: toInt(map[keyToString["SONG_SELECT_ROW_NUMBER"]]) ?? initSettings.songSelectRowNumber,
      displayTimingOffset: toInt(map[keyToString["DISPLAY_TIMING_OFFSET"]]) ?? initSettings.displayTimingOffset,
      fullScreen: toBool(map[keyToString["FULLSCREEN"]]) ?? initSettings.fullScreen,
      editable: toBool(map[keyToString["EDITABLE"]]) ?? initSettings.editable,
      useAiPredictedDifficulty: toBool(map[keyToString["USE_AI_PREDICTED_DIFFICULTY"]]) ?? initSettings.useAiPredictedDifficulty,
      showDebug: toBool(map[keyToString["SHOW_DEBUG"]]) ?? initSettings.showDebug,
      local: toBool(map[keyToString["LOCAL"]]) ?? initSettings.local,
      usePy: toBool(map[keyToString["USE_PY"]]) ?? initSettings.usePy,
      comPort: toInt(map[keyToString["COM_PORT"]]) ?? initSettings.comPort,
    );

    return result;
  }



  /// ファイルに値を書き込む
  /// 書き込み失敗時は例外が返ります
  static Future<void> saveSettingData(File file, Settings value) async {
    String intToStr(int value) {
      return value.toString();
    }

    String boolToStr(bool value) {
      return value ? "1" : "0";
    }

    final data = [
      "${keyToString["VSYNC"]}:${boolToStr(value.vsync)}",
      "${keyToString["FPS"]}:${intToStr(value.fps)}",
      "${keyToString["SHOW_FPS"]}:${boolToStr(value.showFps)}",
      "${keyToString["SOUND_OUTPUT_TYPE"]}:${intToStr(value.soundOutputType)}",
      "${keyToString["WASAPI_EXCLUSIVE"]}:${boolToStr(value.wasapiExclusive)}",
      "${keyToString["ASIO_DRIVER"]}:${intToStr(value.asioDriver)}",
      "${keyToString["BUFFER"]}:${intToStr(value.buffer)}",
      "${keyToString["NOTE_SYMBOL_R"]}:${boolToStr(value.noteSymbol[0])}",
      "${keyToString["NOTE_SYMBOL_G"]}:${boolToStr(value.noteSymbol[1])}",
      "${keyToString["NOTE_SYMBOL_B"]}:${boolToStr(value.noteSymbol[2])}",
      "${keyToString["NOTE_SYMBOL_C"]}:${boolToStr(value.noteSymbol[3])}",
      "${keyToString["NOTE_SYMBOL_M"]}:${boolToStr(value.noteSymbol[4])}",
      "${keyToString["NOTE_SYMBOL_Y"]}:${boolToStr(value.noteSymbol[5])}",
      "${keyToString["NOTE_SYMBOL_W"]}:${boolToStr(value.noteSymbol[6])}",
      "${keyToString["NOTE_SYMBOL_K"]}:${boolToStr(value.noteSymbol[7])}",
      "${keyToString["NOTE_SYMBOL_F"]}:${boolToStr(value.noteSymbol[8])}",
      "${keyToString["BASE_FONT"]}:${value.baseFont}",
      "${keyToString["VSYNC_OFFSET_COMPENSATION"]}:${boolToStr(value.vsyncOffsetCompensation)}",
      "${keyToString["SHOW_STR_SHADOW"]}:${boolToStr(value.showStrShadow)}",
      "${keyToString["USE_HIPERFORMANCE_TIMER"]}:${boolToStr(value.useHighPerformanceTimer)}",
      "${keyToString["SONG_SELECT_ROW_NUMBER"]}:${intToStr(value.songSelectRowNumber)}",
      "${keyToString["DISPLAY_TIMING_OFFSET"]}:${intToStr(value.displayTimingOffset)}",
      "${keyToString["FULLSCREEN"]}:${boolToStr(value.fullScreen)}",
      "${keyToString["EDITABLE"]}:${boolToStr(value.editable)}",
      "${keyToString["USE_AI_PREDICTED_DIFFICULTY"]}:${boolToStr(value.useAiPredictedDifficulty)}",
      "${keyToString["SHOW_DEBUG"]}:${boolToStr(value.showDebug)}",
      "${keyToString["LOCAL"]}:${boolToStr(value.local)}",
      "${keyToString["USE_PY"]}:${boolToStr(value.usePy)}",
      "${keyToString["COM_PORT"]}:${intToStr(value.comPort)}",
    ];
    final writeData = Utf16Encoder().encodeUtf16Le(data.join(Platform. lineTerminator), true);
    await file.writeAsBytes(writeData);
  }

}