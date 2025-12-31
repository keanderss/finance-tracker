import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/utils/breakpoints.dart';
import 'package:personal_finance_tracker/controllers/schedule_controller.dart';
import 'package:personal_finance_tracker/models/payment.dart';
import 'package:personal_finance_tracker/utils/app_routes.dart';
import 'package:personal_finance_tracker/views/widget/components/payment_card.dart';

class ScheduleScreen extends StatelessWidget {
  final controller = Get.find<ScheduleController>();
  ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.paymentCount == 0
              ? const Text('No scheduled payments!')
              : Container(
                  constraints:
                      const BoxConstraints(maxWidth: Breakpoints.tablet),
                  child: ListView(
                    children: <Paymentcard>[
                      for (Payment p in controller.payments)
                        Paymentcard(
                          p,
                          controller,
                          menuItems: <PopupMenuItem>[
                            PopupMenuItem(
                                onTap: () => Get.toNamed(
                                    "${AppRoutes.editSchedule}/${p.id}"),
                                child: const Row(
                                  children: [
                                    Icon(Icons.edit),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Edit")
                                  ],
                                )),
                            PopupMenuItem(
                                onTap: () => controller.remove(p),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Remove")
                                  ],
                                )),
                          ],
                        ),
                    ]..sort(
                        (a, b) => b.payment.date.compareTo(a.payment.date),
                      ),
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'schedule_fab',
        onPressed: () => Get.toNamed("/payments/add"),
        child: const Icon(Icons.payment),
      ),
    );
  }
}
