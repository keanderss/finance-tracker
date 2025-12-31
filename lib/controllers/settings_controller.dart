import 'package:get/get.dart';
import 'package:personal_finance_tracker/models/settings.dart';
import 'package:personal_finance_tracker/services/settings_service.dart';

class SettingsController {
  final SettingsService _service;
  late final Rx<Settings> settings = Settings().obs;

  SettingsController() : _service = SettingsService() {
    settings.value = _service.storage;
  }

  void update(Settings settings) {
    this.settings.value = settings;
    _service.save(settings);
  }
  
  String get locale => settings.value.locale;

  String get currency => settings.value.currency;

  Set<String> get categories => settings.value.categories;
  
}
  