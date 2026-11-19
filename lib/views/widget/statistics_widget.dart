import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance_tracker/utils/breakpoints.dart';
import 'package:personal_finance_tracker/controllers/payments_controller.dart';
import 'package:personal_finance_tracker/controllers/schedule_controller.dart';
import 'package:personal_finance_tracker/controllers/settings_controller.dart';
import 'package:personal_finance_tracker/controllers/statistics_controller.dart';

class StatisticsWidget extends StatelessWidget {
  final payments = Get.find<PaymentController>();
  final schedule = Get.find<ScheduleController>();
  final controller = Get.find<StatisticsController>();
  final settings = Get.find<SettingsController>();

  StatisticsWidget({super.key});

  formatHelper(value) {
    return NumberFormat.currency(
            locale: settings.locale, symbol: settings.currency)
        .format(value / 100);
  }

  Map<String, int> statsToMap(income, expenses) {
    return {"Income": income, "Expenses": expenses, "Total": income + expenses};
  }

  @override
  Widget build(BuildContext context) {
    final stats1 = Obx(
      () => Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text("Scheduled Payments:"),
            for (MapEntry entry in statsToMap(
                    controller.scheduledIncome, controller.scheduledExpenses)
                .entries)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${entry.key}:'),
                  Text(formatHelper(entry.value))
                ],
              ),
            const Text("This month:"),
            for (MapEntry entry in statsToMap(
                    controller.thisMonthIncome, controller.thisMonthExpenses)
                .entries)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${entry.key}:'),
                  Text(formatHelper(entry.value))
                ],
              ),
          ],
        ),
      ),
    );
    final stats2 = Obx(
      () => Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text("Last month:"),
            for (MapEntry entry in statsToMap(
                    controller.lastMonthIncome, controller.lastMonthExpenses)
                .entries)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${entry.key}:'),
                  Text(formatHelper(entry.value))
                ],
              ),
            const Text("This year:"),
            for (MapEntry entry in statsToMap(
                    controller.thisYearIncome, controller.thisYearExpenses)
                .entries)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${entry.key}:'),
                  Text(formatHelper(entry.value))
                ],
              ),
          ],
        ),
      ),
    );
    return Container(
      constraints:
          const BoxConstraints(maxWidth: Breakpoints.tablet, maxHeight: 600),
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth > Breakpoints.mobileL) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [stats1, const SizedBox(width: 64), stats2]);
              } else {
                return Container(
                  constraints: const BoxConstraints(maxHeight: 350),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      stats1,
                      const SizedBox(
                        height: 10,
                      ),
                      stats2
                    ],
                  ),
                );
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Flexible(
            child: Obx(
              () => Container(
                constraints:
                    const BoxConstraints(maxWidth: Breakpoints.mobileL),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Top 3 categories, last 30 days:"),
                    const SizedBox(
                      height: 10,
                    ),
                    if (controller.topSpending30d.isEmpty)
                      const Text(
                          "No categorized spending in the last 30 days!"),
                    for (var i = 0;
                        i < controller.topSpending30d.length.clamp(0, 3);
                        i++)
                      if (controller.topSpending30d.isNotEmpty &&
                          controller.topSpending30d.elementAt(i).value < 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '#${i + 1} ${controller.topSpending30d.elementAt(i).key}',
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              "${formatHelper(controller.topSpending30d.elementAt(i).value)}",
                              textAlign: TextAlign.end,
                            ),
                          ],
                        )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
