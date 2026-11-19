import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:personal_finance_tracker/models/settings.dart';

class SettingsService {
  final box = Hive.box("storage");
  late final String key;

  SettingsService() {
    key = "settings";
    if (box.get(key) == null) {
      box.put(key, Settings().toJson());
    }
  }

  Settings get storage => Settings.fromJson(box.get(key));

  void save(Settings settings) {
    box.put(key, settings.toJson());
  }
}
