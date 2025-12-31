import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/controllers/payments_controller.dart';
import 'package:personal_finance_tracker/models/payment.dart';
import 'package:personal_finance_tracker/utils/app_routes.dart';
import 'package:personal_finance_tracker/controllers/schedule_controller.dart';
import 'package:personal_finance_tracker/views/widget/components/payment_card.dart';

class PendingPaymentsWidget extends StatelessWidget {
  final controller = Get.find<ScheduleController>();
  final payments = Get.find<PaymentController>();
  PendingPaymentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.pendingCount == 0
          ? const SliverToBoxAdapter(
              child: SizedBox(
                height: 300,
                child: Center(
                  child: Text('No pending payments!'),
                ),
              ),
            )
          : SliverList(
              delegate: SliverChildListDelegate(
                <Paymentcard>[
                  for (Payment p in controller.payments)
                    if (p.isPending)
                      Paymentcard(
                        p,
                        controller,
                        menuItems: <PopupMenuItem>[
                          PopupMenuItem(
                              onTap: () => {
                                    payments.add(p.copyWith(
                                        title: p.title,
                                        sum: p.sum,
                                        date: p.date,
                                        scheduled: p.scheduled)),
                                    controller.remove(p),
                                    controller.add(p)
                                  },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Confirm")
                                ],
                              )),
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
                ]..sort((a, b) => a.payment.date.compareTo(b.payment.date)),
              ),
            ),
    );
  }
}
