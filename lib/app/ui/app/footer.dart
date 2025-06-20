import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../businessLogic/SaveDataTransferHandler.dart';
import '../../data/model/settingsFileIO.dart';
import '../../data/settingFilePathProvider.dart';
import '../../data/settingsProvider.dart';
import '../component/NPButton.dart';
import '../component/NPText.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Footer extends ConsumerWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Container(
      color: Theme.of(context).colorScheme.inversePrimary,
      height: 60,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NPButton(
                onPressed: () async {
                  print("ゲームスタート");
                  try {
                    final file = File(ref.read(settingFilePathProvider));
                    final value = ref.read(settingsNotifierProvider);
                    value.whenData((value) async {
                      await SettingsFileIO.saveSettingData(file, value);

                      //ゲームの起動
                      Directory.current = path.join(Directory.current.path, "programs", "application");

                      final exePath = "nature_prhysm.exe";
                      Process process = await Process.start(exePath,[],mode: ProcessStartMode. detached);

                      //ランチャーを閉じる
                      exit(0);
                    });



                  }on PathNotFoundException{
                    showErrorDialog(context, AppLocalizations.of(context)!.save_data_folder_not_found_on_game_start);
                  }on PathAccessException {
                    showErrorDialog(context, AppLocalizations.of(context)!.can_not_write_config_file);
                  }catch (e){
                    showErrorDialog(context, AppLocalizations.of(context)!.error_occurred_while_writing + "\n$e");

                  }
                },
                child: NPText(text: AppLocalizations.of(context)!.start_game_btn_title)
            ),

            NPButton(
                onPressed: (){
                  SaveDataTransferHandler().onClickTransferSaveData(context, ref);
                },
                child: NPText(text: AppLocalizations.of(context)!.transfer_save_data_btn_title)
            ),

          ],
        ),
      ),
    );
  }

  Future<void> showErrorDialog(BuildContext context, String message) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.error),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.ok),
          )
        ],
      ),
    );
  }
}
