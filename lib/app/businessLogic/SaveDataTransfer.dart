import 'dart:io';
import 'package:flutter/material.dart';
import 'package:io/io.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SaveDataTransfer {
  /// データの引継ぎ
  /// [path] データ元のパス
  /// 成功: true, 失敗: false
  Future<bool> transfer(BuildContext context, String sourcePath) async {
    final saveDataDir = Directory(path.join(sourcePath, 'save_data'));
    final destPath = Directory('save_data');

    if (await saveDataDir.exists()) {
      try {
        // 引継ぎ中ダイアログ表示
        showDialog(
          context: context,
          barrierDismissible: false, // ユーザーが閉じられないようにする
          builder: (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.transfer_save_data_dialog_title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLocalizations.of(context)!.moving_save_data),
                SizedBox(height: 20),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );

        // コピー先削除
        if (await destPath.exists()) {
          await destPath.delete(recursive: true);
        }

        // コピー実行
        await copyDirectory(saveDataDir, destPath);

        // 引継ぎ中ダイアログ非表示
        Navigator.pop(context); // ローディングダイアログを閉じる

        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.transfer_save_data_dialog_title),
            content: Text(AppLocalizations.of(context)!.transfer_save_data_completed),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.ok),
              )
            ],
          ),
        );
      } on FileSystemException catch (e) {
        // 引継ぎ中ダイアログ非表示
        Navigator.pop(context); // ローディングダイアログを閉じる
        await showErrorDialog(context, AppLocalizations.of(context)!.can_not_transfer_save_data);
        return false;
      }
    } else {
      await showErrorDialog(context, AppLocalizations.of(context)!.save_data_folder_not_found_on_transfer_save_data);
      return false;
    }

    return true;
  }

  Future<void> copyDirectory(Directory source, Directory destination) async {
    if (!await source.exists()) {
      throw FileSystemException("Source directory not found", source.path);
    }

    await copyPath(source.path,destination.path);
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
