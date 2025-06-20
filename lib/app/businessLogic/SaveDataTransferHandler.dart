import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/settingFilePathProvider.dart';
import '../data/settingsProvider.dart';
import 'SaveDataTransfer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SaveDataTransferHandler {
  final SaveDataTransfer saveDataTransfer = SaveDataTransfer();

  Future<void> onClickTransferSaveData(BuildContext context, WidgetRef ref) async {
    final shouldProceed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.transfer_save_data_dialog_title),
        content: Text(
          AppLocalizations.of(context)!.transfer_save_data_desc,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(AppLocalizations.of(context)!.ok),
          ),
        ],
      ),
    );

    // OKを選択した場合のみ、次の処理を実行
    if (shouldProceed == true) {
      await onClickOkWarningDialog(context, ref);
    }
  }

  Future<void> onClickOkWarningDialog(BuildContext context, WidgetRef ref) async {
    String? selectedPath = await FilePicker.platform.getDirectoryPath();
    if (selectedPath == null) return;

    if (Directory.current.path == selectedPath) {
      await showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text(AppLocalizations.of(context)!.transfer_save_data_dialog_title),
              content: Text(AppLocalizations.of(context)!.select_other_folder),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppLocalizations.of(context)!.ok),
                ),
              ],
            ),
      );
      return;
    }

    bool isSucceed = await saveDataTransfer.transfer(context, selectedPath);
    if (isSucceed) {
      loadSetting(ref);
    }
  }

  Future<void> loadSetting(WidgetRef ref) async {
    final file = File(ref.read(settingFilePathProvider));
    try {
      await ref.read(settingsNotifierProvider.notifier).loadFromFile(file);
    }catch(e){
      print(e);
    }
    // 設定を再読み込みする処理
  }
}
