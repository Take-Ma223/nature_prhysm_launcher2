import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/settingsProvider.dart';
import '../../component/NPNumericInput.dart';
import '../../component/NPSwitch.dart';
import '../../component/NPText.dart';
import '../../layout/DescAndSettingItem.dart';
import '../../layout/SettingGroupCard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            title: AppLocalizations.of(context)!.dev_settings,
            child: Column(
              children: [
                Row(children: [NPText(text: AppLocalizations.of(context)!.dev_settings_desc)]),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:AppLocalizations.of(context)!.show_debug_desc),
                  settingItem: NPSwitch(value: settings.showDebug, onChanged: (isEnable) {ref.read(settingsNotifierProvider.notifier).setShowDebug(isEnable!);}),
                ),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:AppLocalizations.of(context)!.local_desc),
                  settingItem: NPSwitch(value: settings.local, onChanged: (isEnable) {ref.read(settingsNotifierProvider.notifier).setLocal(isEnable!);}),
                ),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:AppLocalizations.of(context)!.use_py_desc),
                  settingItem: NPSwitch(value: settings.usePy, onChanged: (isEnable) {ref.read(settingsNotifierProvider.notifier).setUsePy(isEnable!);}),
                ),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:AppLocalizations.of(context)!.com_port_desc),
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
