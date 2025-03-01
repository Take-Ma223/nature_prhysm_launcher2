import 'package:hooks_riverpod/hooks_riverpod.dart';

final settingFilePathProvider = Provider.autoDispose(
        (ref){
      return "save_data/config.dat";
    }
);