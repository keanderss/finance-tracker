import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/controllers/payments_controller.dart';
import 'package:personal_finance_tracker/models/payment.dart';
import 'package:personal_finance_tracker/controllers/settings_controller.dart';

class Paymentcard extends StatelessWidget {
  final Payment payment;
  final PaymentController controller;
  final SettingsController settings = Get.find<SettingsController>();
  final List<PopupMenuItem> menuItems;

  Paymentcard(this.payment, this.controller,
      {this.menuItems = const <PopupMenuItem>[], super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(Icons.payment),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${payment.category != '' ? '${payment.category}: ' : ''}${payment.title}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Obx(
                          () => Text(
                            DateFormat.yMEd(settings.locale)
                                .add_jm()
                                .format(payment.date),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(minWidth: 50),
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: Obx(
                        () => Text(
                          NumberFormat.currency(
                            locale: settings.locale,
                            symbol: settings.currency,
                          ).format(payment.sum / 100),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton(itemBuilder: (context) => menuItems),
          ],
        ),
      ),
    );
  }
}
