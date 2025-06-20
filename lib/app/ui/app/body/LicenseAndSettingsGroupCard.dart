import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../businessLogic/SetSettingsDefault.dart';
import '../../../data/settingsProvider.dart';
import '../../component/NPButton.dart';
import '../../component/NPText.dart';
import '../../layout/DescAndSettingItem.dart';
import '../../layout/SettingGroupCard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LicenseAndSettingsGroupCard extends ConsumerWidget {
  const LicenseAndSettingsGroupCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(this.toString());

    final settings = ref.watch(settingsNotifierProvider);
    final double space = 20;

    return SettingGroupCard(
      title: AppLocalizations.of(context)!.license_and_settings,
      child: Column(
        children: [
          DescAndSettingItem(
            desc: NPText(text: AppLocalizations.of(context)!.license_desc),
            settingItem: NPButton(
              onPressed: () {
                showLicensePage(context: context);
              },
              child: NPText(text: AppLocalizations.of(context)!.license_btn_title),
            ),
          ),
          Container(height: space),
          DescAndSettingItem(
            desc: NPText(text: AppLocalizations.of(context)!.init_settings_btn_title),
            settingItem: NPButton(
              onPressed: () {
                SetSettingsDefault().onClickSetSettingsDefault(context, ref);
              },
              child: NPText(text: AppLocalizations.of(context)!.init_settings),
            ),
          ),
        ],
      ),
    );
  }
}
