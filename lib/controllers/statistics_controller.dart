import 'package:get/get.dart';
import 'package:personal_finance_tracker/controllers/payments_controller.dart';
import 'package:personal_finance_tracker/controllers/schedule_controller.dart';
import 'package:personal_finance_tracker/models/payment.dart';

class StatisticsController {
  final PaymentController payments = Get.find<PaymentController>();
  final ScheduleController schedule = Get.find<ScheduleController>();

  StatisticsController();

  int _conditionalSum(
          PaymentController controller, bool Function(Payment p) condition) =>
      controller.payments.where(condition).fold(0, (a, b) => a + b.sum);

  int get scheduledExpenses => _conditionalSum(
        schedule,
        (Payment p) => (p.sum < 0),
      );

  int get scheduledIncome => _conditionalSum(
        schedule,
        (Payment p) => (p.sum > 0),
      );

  int get thisMonthExpenses => _conditionalSum(
        payments,
        (Payment p) => (p.sum < 0 &&
            p.date.year == DateTime.now().year &&
            p.date.month == DateTime.now().month),
      );

  int get thisMonthIncome => _conditionalSum(
        payments,
        (Payment p) => (p.sum > 0 &&
            p.date.year == DateTime.now().year &&
            p.date.month == DateTime.now().month),
      );

  int get lastMonthExpenses => _conditionalSum(
        payments,
        (Payment p) => (p.sum < 0 &&
            p.date.year == DateTime.now().year &&
            p.date.month == DateTime.now().month - 1),
      );

  int get lastMonthIncome => _conditionalSum(
        payments,
        (Payment p) => (p.sum > 0 &&
            p.date.year == DateTime.now().year &&
            p.date.month == DateTime.now().month - 1),
      );

  int get thisYearExpenses => _conditionalSum(
        payments,
        (Payment p) => (p.sum < 0 && p.date.year == DateTime.now().year),
      );

  int get thisYearIncome => _conditionalSum(
        payments,
        (Payment p) => (p.sum > 0 && p.date.year == DateTime.now().year),
      );

  int _spendingPerCategory(Payment p, String category,
          bool Function(Payment p) timeFrameCondition) =>
      _conditionalSum(
        payments,
        (Payment p) =>
            p.category != '' &&
            p.category == category &&
            p.sum < 0 &&
            timeFrameCondition(p),
      );

  Map<String, int> _spendingInTimeframe(
          bool Function(Payment p) timeFrameCondition) =>
      Map.fromEntries(
        payments.payments.where((a) => a.category != '').map(
              (b) => MapEntry(
                b.category,
                _spendingPerCategory(
                  b,
                  b.category,
                  (b) => timeFrameCondition(b),
                ),
              ),
            ),
      );

  List<MapEntry<String, int>> _sortedTopSpending(Map<String, int> map) =>
      map.entries.toList()..sort((a, b) => a.value.compareTo(b.value));

  List<MapEntry<String, int>> get topSpending30d =>
      _sortedTopSpending(_spending30d);

  Map<String, int> get _spending30d => _spendingInTimeframe(
        (Payment p) => p.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 30),
          ),
        ),
      );
}
