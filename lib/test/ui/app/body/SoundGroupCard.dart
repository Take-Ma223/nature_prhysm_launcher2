import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/asioDriverProvider.dart';
import '../../../data/settingsProvider.dart';
import '../../component/NPDropDownButton.dart';
import '../../component/NPNumericInput.dart';
import '../../component/NPSwitch.dart';
import '../../component/NPText.dart';
import '../../layout/DescAndSettingItem.dart';
import '../../layout/SettingGroupCard.dart';

class SoundGroupCard extends ConsumerWidget {
  const SoundGroupCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(this.toString());

    final settings = ref.watch(settingsNotifierProvider);
    final double space = 20;
    final asioDriverList = ref.watch(asioDriverProvider);

    return settings.when(
      data:(settings){
        //音声出力タイプによってUIを変える
        Widget detailSettingWidget = SizedBox(width: 0, height: 0);
        if (settings.soundOutputType == 0) {
          //DirectSound
          detailSettingWidget = SizedBox(width: 0, height: 0);
        } else if (settings.soundOutputType == 1) {
          //WASAPI
          detailSettingWidget = Column(
            children: [
              Container(height: space),
              detailSettingWidget = DescAndSettingItem(
                desc: NPText(text: "排他モード\n(ONにすると音声遅延が少なくなります)"),
                settingItem: NPSwitch(
                    value: settings.wasapiExclusive,
                    onChanged: (isEnable) {
                      ref.read(settingsNotifierProvider.notifier).setWasapiExclusive(isEnable!);
                    }),
              ),
            ],
          );
        } else if (settings.soundOutputType == 2) {
          //ASIOドライバ選択値
          int? selectedAsio = settings.asioDriver;
          if (selectedAsio >= asioDriverList.length) {
            selectedAsio = null;
          }
          else if (selectedAsio < 0) {
            selectedAsio = null;
          }


          print("selectedAsio:" + selectedAsio.toString());

          detailSettingWidget = Column(
            children: [
              Container(height: space),
              DescAndSettingItem(
                desc: NPText(text: "ASIOドライバ"),
                settingItem: NPDropDownButton(
                  width: 250,
                  isExpanded: true,
                  value: selectedAsio,
                  items:
                  asioDriverList.asMap().entries.map((entry) {
                    return DropdownMenuItem<int>(
                      value: entry.key,
                      child: Text(entry.value),
                    );
                  }).toList(),
                  onChanged: (driver) {
                    print("ASIO driver:" + driver.toString());
                    ref
                        .read(settingsNotifierProvider.notifier)
                        .setAsioDriver(driver!);
                  },
                ),
              ),
              Container(height: space),
              DescAndSettingItem(
                desc: NPText(text: "バッファサイズ\n(ドライバが対応しているバッファサイズを指定してください)"),
                settingItem: NPNumericInput(
                  value: settings.buffer,
                  min: 1,
                  max: 9999,
                  onChanged: (buffer) {
                    ref.read(settingsNotifierProvider.notifier).setBuffer(buffer.toInt());
                  },
                ),
              ),
            ],
          );
          //ASIO
        } else {
          //assert(false);
          detailSettingWidget = SizedBox(width: 0, height: 0);
        }

        final SoundOutPutTypeList = [
          DropdownMenuItem<int>(value: 0, child: NPText(text: "DirectSound")),
          DropdownMenuItem<int>(value: 1, child: NPText(text: "WASAPI")),
          DropdownMenuItem<int>(value: 2, child: NPText(text: "ASIO")),
        ];

        var selectedSoundOutputType = settings.soundOutputType;
        if(SoundOutPutTypeList.indexWhere((widget){return widget.value == selectedSoundOutputType;}) == -1){
          selectedSoundOutputType = 1;
        }

        return SettingGroupCard(
          title: "サウンド",
          child: Column(
            children: [
              DescAndSettingItem(
                desc: NPText(
                  text: "音声出力タイプ(WASAPI推奨)",
                ),
                settingItem: NPDropDownButton(
                  width: 120,
                  isExpanded: true,
                  value: selectedSoundOutputType,
                  items: [
                    DropdownMenuItem<int>(value: 0, child: NPText(text: "DirectSound")),
                    DropdownMenuItem<int>(value: 1, child: NPText(text: "WASAPI")),
                    DropdownMenuItem<int>(value: 2, child: NPText(text: "ASIO")),
                  ],
                  onChanged: (type) {
                    ref
                        .read(settingsNotifierProvider.notifier)
                        .setSoundOutputType(type!);
                  },
                ),
              ),
              detailSettingWidget,
            ],
          ),
        );
      },
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => NPText(text: 'Error: $err'),
    );
  }
}
