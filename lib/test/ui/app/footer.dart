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
                    showErrorDialog(context,"save_dataフォルダが見つからないため、\n設定を書き込めません。");
                  }on PathAccessException {
                    showErrorDialog(context,"他のアプリケーションによってconfig.datファイルが開かれているため、\n設定を書き込めません。\nファイルを開いているアプリケーションを終了してください。");
                  }catch (e){
                    showErrorDialog(context,"設定の書き込み中にエラーが発生しました。\n$e");

                  }
                },
                child: NPText(text: "ゲームスタート")
            ),

            NPButton(
                onPressed: (){
                  SaveDataTransferHandler().onClickTransferSaveData(context, ref);
                },
                child: NPText(text: "セーブデータの引継ぎ(ver1.30以降)")
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
        title: Text("エラー"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          )
        ],
      ),
    );
  }
}
