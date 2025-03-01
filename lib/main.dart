import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nature_prhysm_launcher/test/ui/app/body/Body.dart';
import 'package:nature_prhysm_launcher/test/ui/app/footer.dart';
import 'package:window_manager/window_manager.dart';

import 'test/data/settingFilePathProvider.dart';
import 'test/data/settingsProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(800, 800),
    minimumSize: Size(640, 640),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    title: "nature prhysm launcher",
    titleBarStyle: TitleBarStyle.normal,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const ProviderScope(child: Home()));
}

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Uri scriptUri = Platform.script;
    String scriptPath = scriptUri.toFilePath();
    print('scriptPath: ${scriptPath}');
    if (kDebugMode) {
      // デバッグ実行時はカレントディレクトリを変更しない
    }else{
      // リリース実行時のみディレクトリを変更
      Directory.current = Directory.current.parent.parent;
    }

    print('Current directory: ${Directory.current.path}');

    return App();
  }
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'nature prhysm launcher',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const Contents(title: 'nature prhysm launcher'),
    );
  }
}

class Contents extends ConsumerWidget {
  const Contents({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final widget = Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Expanded(child: Body()), Footer()],
        ),
      ),
    );

    print("Contents build");

    return widget;
  }

  Future<void> showErrorDialog(BuildContext context, String message) async {
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("エラー"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
    );
  }
}
