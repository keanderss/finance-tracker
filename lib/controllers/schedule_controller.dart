import 'dart:async';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/controllers/payments_controller.dart';
import 'package:personal_finance_tracker/models/payment.dart';
import 'package:personal_finance_tracker/services/payments_service.dart';

class ScheduleController extends PaymentController {
  final RxList<Payment> pending;
  late final Timer _timer;

  ScheduleController()
      : pending = <Payment>[].obs,
        super(serviceOverride: PaymentService.scheduled()) {
    pending.value = _pendingPayments;
    _timer = Timer.periodic(
        const Duration(seconds: 1), (t) => pending.value = _pendingPayments);
  }

  @override
  void add(Payment payment) {
    int year = payment.date.year;
    int month = payment.date.month + 1;
    int day = payment.date.day;
    int lastday = DateTime(year, month + 1, 0).day;

    if (month > 12) {
      month = 1;
      year++;
    }

    if (day > lastday) {
      day = lastday;
    }

    DateTime nextDate = DateTime(
      year,
      month,
      day,
      payment.date.hour,
      payment.date.minute,
      payment.date.second,
      payment.date.millisecond,
      payment.date.microsecond,
    );

    Payment nextPayment = payment.copyWith(
        title: payment.title,
        sum: payment.sum,
        date: nextDate,
        scheduled: payment.scheduled);

    super.add(nextPayment);
  }

  get _pendingPayments =>
      payments.whereType<Payment>().where((p) => p.isPending).toList();

  get _pendingCount =>
      payments.whereType<Payment>().where((p) => p.isPending).length;

  get pendingPayments => pending;

  get pendingCount => pending.length;
}
