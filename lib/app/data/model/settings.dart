import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'settings.freezed.dart';

@freezed
class Settings with _$Settings {
  const factory Settings({
    required final String locale,

    required final bool vsync,
    required final int fps,
    required final bool showFps,

    required final int soundOutputType,
    required final bool wasapiExclusive,
    required final int asioDriver,
    required final int buffer,

    required final List<bool> noteSymbol,

    required final bool useDefaultFont,
    required final String baseFont,

    required final bool vsyncOffsetCompensation,
    required final bool showStrShadow,
    required final bool useHighPerformanceTimer,
    required final int songSelectRowNumber,
    required final int displayTimingOffset,
    required final bool fullScreen,
    required final bool editable,
    required final bool useAiPredictedDifficulty,

    required final bool showDebug,
    required final bool local,
    required final bool usePy,
    required final int comPort,
  }) = _Settings;

  static Settings getDefault() {
    return Settings(
      locale: "ja",
      vsync: false,
      fps: 450,
      showFps: false,
      soundOutputType: 1,
      wasapiExclusive: true,
      asioDriver: -1,
      buffer: 256,
      noteSymbol: [true, true, true, true, true, true, true, true, true],
      useDefaultFont: true,
      baseFont: "Noto Sans CJK JP Black",
      vsyncOffsetCompensation: false,
      showStrShadow: true,
      useHighPerformanceTimer: true,
      songSelectRowNumber: 15,
      displayTimingOffset: 0,
      fullScreen: false,
      editable: false,
      useAiPredictedDifficulty: false,
      showDebug: true,
      local: false,
      usePy: false,
      comPort: 0,
    );
  }
}
