import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance_tracker/controllers/core_controller.dart';
import 'package:personal_finance_tracker/controllers/payments_controller.dart';
import 'package:personal_finance_tracker/controllers/schedule_controller.dart';
import 'package:personal_finance_tracker/utils/app_routes.dart';
import 'package:personal_finance_tracker/utils/app_scroll_behavior.dart';
import 'package:personal_finance_tracker/controllers/settings_controller.dart';
import 'package:personal_finance_tracker/controllers/statistics_controller.dart';

Future<void> main() async {
  Intl.defaultLocale = 'en_US';
  initializeDateFormatting();
  await Hive.initFlutter();
  await Hive.openBox("storage");
  Get.lazyPut<CoreController>(() => CoreController());
  Get.lazyPut<PaymentController>(() => PaymentController());
  Get.lazyPut<ScheduleController>(() => ScheduleController());
  Get.put<SettingsController>(SettingsController());
  Get.put<StatisticsController>(StatisticsController());
  runApp(
    GetMaterialApp(
        title: 'Finance Tracker',
        scrollBehavior: AppScrollBehavior(),
        initialRoute: AppRoutes.root,
        getPages: AppRoutes.getroutes),
  );
}
