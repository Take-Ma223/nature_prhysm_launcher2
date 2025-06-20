import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nature_prhysm_launcher/app/ui/app/body/LocaleGroupCard.dart';
import '../../../data/settingsProvider.dart';
import 'DevGroupCard.dart';
import 'FontGroupCard.dart';
import 'GraphicGroupCard.dart';
import 'LicenseAndSettingsGroupCard.dart';
import 'NoteSymbolGroupCard.dart';
import 'OtherGroupCard.dart';
import 'SoundGroupCard.dart';

class Body extends ConsumerWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(this.toString());
    final settings = ref.watch(settingsNotifierProvider);

    final double space = 20;
    Uri scriptUri = Platform.script;

    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: ListView(
          children: [
            LocaleGroupCard(),
            Container(height: space),
            GraphicGroupCard(),
            Container(height: space),
            SoundGroupCard(),
            Container(height: space),
            NoteSymbolGroupCard(),
            Container(height: space),
            FontGroupCard(),
            Container(height: space),
            OtherGroupCard(),
            Container(height: space),
            DevGroupCard(),
            Container(height: space),
            LicenseAndSettingsGroupCard()
          ],
        ),
      ),
    );
  }
}
