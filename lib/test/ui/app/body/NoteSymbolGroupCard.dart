import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/settingsProvider.dart';
import '../../component/NPSwitch.dart';
import '../../component/NPText.dart';
import '../../layout/DescAndSettingItem.dart';
import '../../layout/SettingGroupCard.dart';

class NoteSymbolGroupCard extends ConsumerWidget {
  const NoteSymbolGroupCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(this.toString());

    final settings = ref.watch(settingsNotifierProvider);

    final List<String> noteImgPath = [
      'assets/img/notes/r.png',
      'assets/img/notes/g.png',
      'assets/img/notes/b.png',
      'assets/img/notes/c.png',
      'assets/img/notes/m.png',
      'assets/img/notes/y.png',
      'assets/img/notes/w.png',
      'assets/img/notes/k.png',
      'assets/img/notes/f.png',
    ];

    final List<String> desc = [
      '赤色(R)',
      '緑色(G)',
      '青色(B)',
      '水色(C)',
      '紫色(M)',
      '黄色(Y)',
      '白色(W)',
      '黒色(K)',
      '虹色(F)',
    ];

    return settings.when(
        data: (settings){
          return SettingGroupCard(
            title: "音符記号設定",
            child: Column(
              children: [
                Row(children: [NPText(text: "チェックを付けた色の音符に記号を表示できます")]),
                Row(children: [NPText(text: "記号の種類はゲームオプションのnote symbolで変更できます"),],),
                for(int i=0; i<9;i++)...{
                  DescAndSettingItem(
                    desc: Row(children: [
                      Image.asset(noteImgPath[i], scale: 4),
                      NPText(text: desc[i])]),
                    settingItem: NPSwitch(
                      value: settings.noteSymbol[i],
                      onChanged: (isChecked) {
                        ref.read(settingsNotifierProvider.notifier).setNoteSymbol(i, isChecked!);
                      },
                    ),
                  ),
                }
              ],
            ),
          );
        },
        loading: () => CircularProgressIndicator(),
        error: (err, stack) => NPText(text: 'Error: $err'),
    );
  }
}
