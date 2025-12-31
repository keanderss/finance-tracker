import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/utils/breakpoints.dart';
import 'package:personal_finance_tracker/controllers/schedule_controller.dart';
import 'package:personal_finance_tracker/views/widget/pending_payments_widget.dart';
import 'package:personal_finance_tracker/views/widget/statistics_widget.dart';

class HomeScreen extends StatelessWidget {
  final ScheduleController schedule = Get.find<ScheduleController>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: Breakpoints.tablet,),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  constraints:
                      const BoxConstraints(maxWidth: Breakpoints.tablet),
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                  ),
                  child: const Text(
                    "Statistics",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: StatisticsWidget(),
              ),
              SliverToBoxAdapter(
                child: Container(
                  constraints:
                      const BoxConstraints(maxWidth: Breakpoints.tablet),
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                  ),
                  child: Obx(
                    () => Text(
                      "Pending Payments ${schedule.pendingCount > 0 ? '(${schedule.pendingCount})' : ''}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              PendingPaymentsWidget()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'home_fab',
        onPressed: () => Get.toNamed("/payments/add"),
        child: const Icon(Icons.payment),
      ),
    );
  }
}
