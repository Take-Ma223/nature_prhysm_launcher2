import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/settingsProvider.dart';
import '../../component/NPNumericInput.dart';
import '../../component/NPSwitch.dart';
import '../../component/NPText.dart';
import '../../layout/DescAndSettingItem.dart';
import '../../layout/SettingGroupCard.dart';

class OtherGroupCard extends ConsumerWidget {
  const OtherGroupCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(this.toString());

    final double space = 20;

    final settings = ref.watch(settingsNotifierProvider);

    return settings.when(
        data: (settings){
          return SettingGroupCard(
            title: "その他設定(変更非推奨)",
            child: Column(
              children: [
                DescAndSettingItem(
                  desc: NPText(text:"音符の判定タイミングを1フレーム遅らせる(垂直同期ONの時のみ有効)"),
                  settingItem: NPSwitch(value: settings.vsyncOffsetCompensation, onChanged: (isEnable) {ref.read(settingsNotifierProvider.notifier).setVsyncOffsetCompensation(isEnable!);}),
                ),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:"文字の影を表示する"),
                  settingItem: NPSwitch(value: settings.showStrShadow, onChanged: (isEnable) {ref.read(settingsNotifierProvider.notifier).setShowStrShadow(isEnable!);}),
                ),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:"高精度タイマーを使用する"),
                  settingItem: NPSwitch(value: settings.useHighPerformanceTimer, onChanged: (isEnable) {ref.read(settingsNotifierProvider.notifier).setUseHighPerformanceTimer(isEnable!);}),
                ),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:"選曲画面で表示する曲数"),
                  settingItem: NPNumericInput(value: settings.songSelectRowNumber, min: 3, max: 15, onChanged: (number){ref.read(settingsNotifierProvider.notifier).setSongSelectRowNumber(number.toInt());}),
                ),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:"譜面表示タイミングオフセット(ms)\n(ディスプレイ遅延の補正用です 基本的に0にしてください)"),
                  settingItem: NPNumericInput(value: settings.displayTimingOffset, min: 0, max: 1000, onChanged: (number){ref.read(settingsNotifierProvider.notifier).setDisplayTimingOffset(number.toInt());}),
                ),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:"フルスクリーンで起動(正常に動作しない可能性があります)"),
                  settingItem: NPSwitch(value: settings.fullScreen, onChanged: (isEnable) {ref.read(settingsNotifierProvider.notifier).setFullScreen(isEnable!);}),
                ),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:"譜面を編集可能にする"),
                  settingItem: NPSwitch(value: settings.editable, onChanged: (isEnable) {ref.read(settingsNotifierProvider.notifier).setEditable(isEnable!);}),
                ),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:"選曲画面でAI予測難易度を使用する"),
                  settingItem: NPSwitch(value: settings.useAiPredictedDifficulty, onChanged: (isEnable) {ref.read(settingsNotifierProvider.notifier).setUseAiPredictedDifficulty(isEnable!);}),
                ),
              ],
            ),
          );
        },
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => NPText(text: 'Error: $err'),
    );

  }
}
