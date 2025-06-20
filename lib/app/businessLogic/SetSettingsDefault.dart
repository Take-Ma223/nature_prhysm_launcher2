import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/settingsProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SetSettingsDefault {
  //final SaveDataTransfer saveDataTransfer = SaveDataTransfer();

  Future<void> onClickSetSettingsDefault(BuildContext context, WidgetRef ref) async {
    final shouldProceed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.init_settings_dialog_title),
        content: Text(
          AppLocalizations.of(context)!.init_settings_desc,
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
        title: Text(AppLocalizations.of(context)!.init_settings_dialog_title),
        content: Text(
            AppLocalizations.of(context)!.init_settings_completed,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(AppLocalizations.of(context)!.ok),
          ),
        ],
      ),
    );
  }
}