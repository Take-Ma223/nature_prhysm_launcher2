import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/fontProvider.dart';
import '../../../data/settingsProvider.dart';
import '../../component/NPDropDownButton.dart';
import '../../component/NPSwitch.dart';
import '../../component/NPText.dart';
import '../../layout/DescAndSettingItem.dart';
import '../../layout/SettingGroupCard.dart';

class FontGroupCard extends ConsumerWidget {
  const FontGroupCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(this.toString());

    final double space = 20;

    final settings = ref.watch(settingsNotifierProvider);

    final fontListAsync = ref.watch(fontNameListProvider);

    return settings.when(
      data: (settings){
        //フォント選択Widgetの作成
        final fontSelectorWidget = fontListAsync.when(
          data: (fontList) {
            String? selectedFont = settings.baseFont;
            if (!fontList.contains(selectedFont)) {
              selectedFont = null;
            }

            return Column(
              children: [
                NPDropDownButton(
                  width: 300,
                  isExpanded: true,
                  value: selectedFont,
                  items:
                  fontList.map((font) {
                    return DropdownMenuItem<String>(
                      value: font,
                      child: Text(font, style: TextStyle(fontFamily: font)),
                    );
                  }).toList(),
                  onChanged: (font) {
                    ref.read(settingsNotifierProvider.notifier).setBaseFont(font!);
                  },
                ),
              ],
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (e, stack) => Center(child: Text("エラー: $e")),
        );

        Widget fontSelectWidget;
        if(settings.useDefaultFont){
          fontSelectWidget = SizedBox(width: 0,height: 0);
        }else{
          fontSelectWidget = Column(
            children: [
              Container(height: space),
              DescAndSettingItem(
                desc: NPText(text: "ゲームで使用するフォントを変更"),
                settingItem: fontSelectorWidget,
              ),
            ],
          );
        }

        return SettingGroupCard(
          title: "フォント設定",
          child: Column(
            children: [
              DescAndSettingItem(
                desc: NPText(text:"デフォルトフォントを使用"),
                settingItem: NPSwitch(value: settings.useDefaultFont, onChanged: (isEnable) {ref.read(settingsNotifierProvider.notifier).setUseDefaultFont(isEnable!);}),
              ),
              fontSelectWidget
            ],
          ),
        );

      },
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => NPText(text: 'Error: $err'),
    );

  }
}
