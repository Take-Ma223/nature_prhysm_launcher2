import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/settingsProvider.dart';
import '../../component/NPNumericInput.dart';
import '../../component/NPSwitch.dart';
import '../../component/NPText.dart';
import '../../layout/DescAndSettingItem.dart';
import '../../layout/SettingGroupCard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          title: AppLocalizations.of(context)!.graphic,
          child: Column(
            children: [
              DescAndSettingItem(
                desc: NPText(
                  text: AppLocalizations.of(context)!.vsync_desc,
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
                desc: NPText(text: AppLocalizations.of(context)!.fps_desc),
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
                desc: NPText(text: AppLocalizations.of(context)!.show_fps_desc),
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
