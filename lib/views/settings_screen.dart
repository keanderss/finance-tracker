import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/controllers/settings_controller.dart';
import 'package:personal_finance_tracker/views/forms/settings_form.dart';

class SettingsScreen extends StatelessWidget {
  final SettingsController controller = Get.find<SettingsController>();

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsForm()
    );
  }
}
