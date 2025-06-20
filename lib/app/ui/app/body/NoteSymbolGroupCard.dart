import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/settingsProvider.dart';
import '../../component/NPSwitch.dart';
import '../../component/NPText.dart';
import '../../layout/DescAndSettingItem.dart';
import '../../layout/SettingGroupCard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      AppLocalizations.of(context)!.red,
      AppLocalizations.of(context)!.green,
      AppLocalizations.of(context)!.blue,
      AppLocalizations.of(context)!.cyan,
      AppLocalizations.of(context)!.magenta,
      AppLocalizations.of(context)!.yellow,
      AppLocalizations.of(context)!.white,
      AppLocalizations.of(context)!.black,
      AppLocalizations.of(context)!.rainbow,
    ];

    return settings.when(
        data: (settings){
          return SettingGroupCard(
            title: AppLocalizations.of(context)!.note_symbol,
            child: Column(
              children: [
                Row(children: [NPText(text: AppLocalizations.of(context)!.note_symbol_desc1)]),
                Row(children: [NPText(text: AppLocalizations.of(context)!.note_symbol_desc2),],),
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
