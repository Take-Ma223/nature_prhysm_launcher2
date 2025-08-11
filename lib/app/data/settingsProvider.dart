import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nature_prhysm_launcher/app/data/settingFilePathProvider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'model/settings.dart';
import 'model/settingsFileIO.dart';
part 'settingsProvider.g.dart';

@riverpod
Future<Settings> fetchConfiguration(Ref ref) async {
  return await SettingsFileIO.loadSettingData(File(ref.read(settingFilePathProvider)));
}

@riverpod
class SettingsNotifier extends _$SettingsNotifier{
  @override
  Future<Settings> build() async {
    print("SettingsNotifier build");
    return await fetchConfiguration(ref);
  }

  Future<void> setDefault() async{
    print("SettingsNotifier setDefault");
    state = AsyncValue.data(_getDefaultState());
  }

  Future<void> loadFromFile(File file) async {
    print("SettingsNotifier loadFromFile");
    update((data){
      state = const AsyncLoading();
      return SettingsFileIO.loadSettingData(file);
    });

  }

  /// デフォルト値
  Settings _getDefaultState(){
    return Settings.getDefault();
  }

  void setLocale(String locale) {
    update((data) => data.copyWith(locale: locale));
  }

  void setVsync(bool isEnable) {
    update((data) => data.copyWith(vsync: isEnable));
  }

  void setFps(int fps) {
    update((data) => data.copyWith(fps: fps));
  }

  void setShowFps(bool isEnable) {
    update((data) => data.copyWith(showFps: isEnable));
  }

  void setSoundOutputType(int type) {
    update((data) => data.copyWith(soundOutputType: type));
  }

  void setWasapiExclusive(bool isEnable) {
    update((data) => data.copyWith(wasapiExclusive: isEnable));
  }

  void setAsioDriver(int driver) {
    update((data) => data.copyWith(asioDriver: driver));
  }

  void setBuffer(int buffer) {
    update((data) => data.copyWith(buffer: buffer));
  }

  void setNoteSymbol(int index, bool isEnable) {
    update((data) {
      final List<bool> newList = List<bool>.from(data.noteSymbol);
      newList[index] = isEnable;
      return data.copyWith(noteSymbol: newList);
    });
  }

  void setUseDefaultFont(bool isEnable) {
    update((data) => data.copyWith(useDefaultFont: isEnable));
  }

  void setBaseFont(String font) {
    update((data) => data.copyWith(baseFont: font));
  }

  void setVsyncOffsetCompensation(bool isEnable) {
    update((data) => data.copyWith(vsyncOffsetCompensation: isEnable));
  }

  void setShowStrShadow(bool isEnable) {
    update((data) => data.copyWith(showStrShadow: isEnable));
  }

  void setUseHighPerformanceTimer(bool isEnable) {
    update((data) => data.copyWith(useHighPerformanceTimer: isEnable));
  }

  void setSongSelectRowNumber(int number) {
    update((data) => data.copyWith(songSelectRowNumber: number));
  }

  void setDisplayTimingOffset(int number) {
    update((data) => data.copyWith(displayTimingOffset: number));
  }

  void setFullScreen(bool isEnable) {
    update((data) => data.copyWith(fullScreen: isEnable));
  }

  void setEditable(bool isEnable) {
    update((data) => data.copyWith(editable: isEnable));
  }

  void setUseAiPredictedDifficulty(bool isEnable) {
    update((data) => data.copyWith(useAiPredictedDifficulty: isEnable));
  }

  void setUseEnterInsteadOfSpaceWhenAutoMode(bool isEnable) {
    update((data) => data.copyWith(useEnterInsteadOfSpaceWhenAutoMode: isEnable));
  }

  void setShowDebug(bool isEnable) {
    update((data) => data.copyWith(showDebug: isEnable));
  }

  void setLocal(bool isEnable) {
    update((data) => data.copyWith(local: isEnable));
  }

  void setUsePy(bool isEnable) {
    update((data) => data.copyWith(usePy: isEnable));
  }

  void setComPort(int number) {
    update((data) => data.copyWith(comPort: number));
  }


}
