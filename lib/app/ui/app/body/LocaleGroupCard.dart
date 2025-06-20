import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/settingsProvider.dart';
import '../../component/NPDropDownButton.dart';
import '../../component/NPNumericInput.dart';
import '../../component/NPSwitch.dart';
import '../../component/NPText.dart';
import '../../layout/DescAndSettingItem.dart';
import '../../layout/SettingGroupCard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocaleGroupCard extends ConsumerWidget {
  const LocaleGroupCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(this.toString());

    final double space = 20;

    final settings = ref.watch(settingsNotifierProvider);

    final localeList = [
      DropdownMenuItem<String>(value: "ja", child: NPText(text: "日本語")),
      DropdownMenuItem<String>(value: "en", child: NPText(text: "English")),
      DropdownMenuItem<String>(value: "ko", child: NPText(text: "한국어")),
    ];

    return settings.when(
      data: (settings){
        var selectedLocale = settings.locale;
        if(localeList.indexWhere((widget){return widget.value == selectedLocale;}) == -1){
          selectedLocale = "ja";
        }

        return SettingGroupCard(
          title: AppLocalizations.of(context)!.language_settings,
          child: Column(
            children: [
              DescAndSettingItem(
                desc: NPText(text:AppLocalizations.of(context)!.language),
                settingItem: NPDropDownButton(
                  width: 120,
                  isExpanded: true,
                  value: selectedLocale,
                  items: localeList,
                  onChanged: (locale) {
                    ref.read(settingsNotifierProvider.notifier).setLocale(locale!);
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
