import 'package:get/get.dart';
import 'package:personal_finance_tracker/models/payment.dart';
import 'package:personal_finance_tracker/services/payments_service.dart';

class PaymentController {
  late final PaymentService service;
  final RxList<Payment> payments;

  PaymentController({PaymentService? serviceOverride})
      : payments = <Payment>[].obs {
    service = serviceOverride ?? PaymentService();
    payments.value = service.storage;
  }

  void add(Payment payment) {
    payments.add(payment);
    service.save(payments);
  }

  Payment? findById(String? id) {
    return payments.firstWhereOrNull((p) => p.id == id);
  }

  void update(Payment payment) {
    int index = payments.indexWhere((p) => p.id == payment.id);
    if (index >= 0) {
      payments[index] = payment;
      service.save(payments);
    } else {
      print("index error");
      print(payment.id);
    }
  }

  void remove(Payment payment) {
    payments.remove(payment);
    service.save(payments);
  }

  get paymentCount => payments.length;
}
