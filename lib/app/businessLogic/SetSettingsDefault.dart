import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/settingsProvider.dart';

class SetSettingsDefault {
  //final SaveDataTransfer saveDataTransfer = SaveDataTransfer();

  Future<void> onClickSetSettingsDefault(BuildContext context, WidgetRef ref) async {
    final shouldProceed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text("デフォルト設定に戻す"),
        content: Text(
          "設定値をデフォルトに戻しますか？",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text("いいえ"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text("はい"),
          ),
        ],
      ),
    );

    // はいを選択した場合のみ、次の処理を実行
    if (shouldProceed == true) {
      await onClickOkWarningDialog(context, ref);
    }
  }

  Future<void> onClickOkWarningDialog(BuildContext context, WidgetRef ref) async {
    ref.read(settingsNotifierProvider.notifier).setDefault();

    final shouldProceed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text("デフォルト設定に戻す"),
        content: Text(
          "設定値をデフォルトに戻しました。",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}