import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/settingsProvider.dart';
import '../../component/NPNumericInput.dart';
import '../../component/NPSwitch.dart';
import '../../component/NPText.dart';
import '../../layout/DescAndSettingItem.dart';
import '../../layout/SettingGroupCard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            title: AppLocalizations.of(context)!.other_settings,
            child: Column(
              children: [
                DescAndSettingItem(
                  desc: NPText(text:AppLocalizations.of(context)!.vsync_offset_compensation_desc),
                  settingItem: NPSwitch(value: settings.vsyncOffsetCompensation, onChanged: (isEnable) {ref.read(settingsNotifierProvider.notifier).setVsyncOffsetCompensation(isEnable!);}),
                ),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:AppLocalizations.of(context)!.show_str_shadow_desc),
                  settingItem: NPSwitch(value: settings.showStrShadow, onChanged: (isEnable) {ref.read(settingsNotifierProvider.notifier).setShowStrShadow(isEnable!);}),
                ),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:AppLocalizations.of(context)!.use_high_performance_timer_desc),
                  settingItem: NPSwitch(value: settings.useHighPerformanceTimer, onChanged: (isEnable) {ref.read(settingsNotifierProvider.notifier).setUseHighPerformanceTimer(isEnable!);}),
                ),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:AppLocalizations.of(context)!.song_select_row_number_desc),
                  settingItem: NPNumericInput(value: settings.songSelectRowNumber, min: 3, max: 15, onChanged: (number){ref.read(settingsNotifierProvider.notifier).setSongSelectRowNumber(number.toInt());}),
                ),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:AppLocalizations.of(context)!.display_timing_offset_desc),
                  settingItem: NPNumericInput(value: settings.displayTimingOffset, min: 0, max: 1000, onChanged: (number){ref.read(settingsNotifierProvider.notifier).setDisplayTimingOffset(number.toInt());}),
                ),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:AppLocalizations.of(context)!.full_screen_desc),
                  settingItem: NPSwitch(value: settings.fullScreen, onChanged: (isEnable) {ref.read(settingsNotifierProvider.notifier).setFullScreen(isEnable!);}),
                ),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:AppLocalizations.of(context)!.editable_desc),
                  settingItem: NPSwitch(value: settings.editable, onChanged: (isEnable) {ref.read(settingsNotifierProvider.notifier).setEditable(isEnable!);}),
                ),
                Container(height: space),
                DescAndSettingItem(
                  desc: NPText(text:AppLocalizations.of(context)!.use_ai_predicted_difficulty),
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
