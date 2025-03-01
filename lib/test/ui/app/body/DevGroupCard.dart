import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/settingsProvider.dart';
import '../../component/NPNumericInput.dart';
import '../../component/NPSwitch.dart';
import '../../component/NPText.dart';
import '../../layout/DescAndSettingItem.dart';
import '../../layout/SettingGroupCard.dart';

class DevGroupCard extends ConsumerWidget {
  const DevGroupCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(this.toString());
    final double space = 20;

    final settings = ref.watch(settingsNotifierProvider);

    return settings.when(
        data: (settings){
          return SettingGroupCard(
            title: "開発者用設定",
            child: Column(
              children: [
                Row(children: [NPText(text: "開発者用の設定です　変更する必要はありません")]),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:"オートプレイの表示"),
                  settingItem: NPSwitch(value: settings.showDebug, onChanged: (isEnable) {ref.read(settingsNotifierProvider.notifier).setShowDebug(isEnable!);}),
                ),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:"サーバー接続先をローカルにする"),
                  settingItem: NPSwitch(value: settings.local, onChanged: (isEnable) {ref.read(settingsNotifierProvider.notifier).setLocal(isEnable!);}),
                ),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:"pythonスクリプトの使用"),
                  settingItem: NPSwitch(value: settings.usePy, onChanged: (isEnable) {ref.read(settingsNotifierProvider.notifier).setUsePy(isEnable!);}),
                ),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:"COM PORT\n(専用コントローラ接続用)"),
                  settingItem: NPNumericInput(value:settings.comPort, min:0, max: 99999, onChanged: (comPort) {ref.read(settingsNotifierProvider.notifier).setComPort(comPort.toInt());}),
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
