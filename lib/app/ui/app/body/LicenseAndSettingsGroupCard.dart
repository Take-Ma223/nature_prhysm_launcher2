import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../businessLogic/SetSettingsDefault.dart';
import '../../../data/settingsProvider.dart';
import '../../component/NPButton.dart';
import '../../component/NPText.dart';
import '../../layout/DescAndSettingItem.dart';
import '../../layout/SettingGroupCard.dart';

class LicenseAndSettingsGroupCard extends ConsumerWidget {
  const LicenseAndSettingsGroupCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(this.toString());

    final settings = ref.watch(settingsNotifierProvider);
    final double space = 20;

    return SettingGroupCard(
      title: "ライセンス・設定",
      child: Column(
        children: [
          DescAndSettingItem(
            desc: NPText(text: "ライセンスの表示"),
            settingItem: NPButton(
              onPressed: () {
                showLicensePage(context: context);
              },
              child: NPText(text: "ライセンス"),
            ),
          ),
          Container(height: space),
          DescAndSettingItem(
            desc: NPText(text: "デフォルト設定に戻す"),
            settingItem: NPButton(
              onPressed: () {
                SetSettingsDefault().onClickSetSettingsDefault(context, ref);
              },
              child: NPText(text: "デフォルト設定に戻す"),
            ),
          ),
        ],
      ),
    );
  }
}
