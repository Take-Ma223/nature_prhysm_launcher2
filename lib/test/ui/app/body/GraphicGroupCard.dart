import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/settingsProvider.dart';
import '../../component/NPNumericInput.dart';
import '../../component/NPSwitch.dart';
import '../../component/NPText.dart';
import '../../layout/DescAndSettingItem.dart';
import '../../layout/SettingGroupCard.dart';

class GraphicGroupCard extends ConsumerWidget {
  const GraphicGroupCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(this.toString());
    final double space = 20;

    final settings = ref.watch(settingsNotifierProvider);
    return settings.when(
      data: (settings) {
        return SettingGroupCard(
          title: "グラフィック",
          child: Column(
            children: [
              DescAndSettingItem(
                desc: NPText(
                  text: "垂直同期をONにする\n(OFFを推奨しますが、音符がカクつく場合はONにしてください)",
                ),
                settingItem: NPSwitch(
                  value: settings.vsync,
                  onChanged: (isEnable) {
                    ref
                        .read(settingsNotifierProvider.notifier)
                        .setVsync(isEnable!);
                  },
                ),
              ),
              Container(height: space),
              DescAndSettingItem(
                desc: NPText(text: "フレームレート(垂直同期OFF時のみ有効)"),
                settingItem: NPNumericInput(
                  min: 1,
                  max: 999,
                  value: settings.fps,
                  onChanged: (fps) {
                    ref
                        .read(settingsNotifierProvider.notifier)
                        .setFps(fps.toInt());
                  },
                ),
              ),
              Container(height: space),
              DescAndSettingItem(
                desc: NPText(text: "フレームレートを表示する"),
                settingItem: NPSwitch(
                  value: settings.showFps,
                  onChanged: (isEnable) {
                    ref
                        .read(settingsNotifierProvider.notifier)
                        .setShowFps(isEnable!);
                  },
                ),
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
