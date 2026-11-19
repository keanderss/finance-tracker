import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:personal_finance_tracker/models/payment.dart';

class PaymentService {
  final box = Hive.box("storage");
  late final String key;
  
  PaymentService() {
    key = "payments";
    if (box.get(key) == null) {
      box.put(key, []);
    }
  }

  PaymentService.scheduled() {
    key = "scheduled";
    if (box.get(key) == null) {
      box.put(key, []);
    }
  }

  List<Payment> get storage => box
      .get(key)
      .map<Payment>(
        (json) => Payment.fromJson(json),
      )
      .toList();

  void save(payments) {
    box.put(
      key,
      payments.map((Payment payment) => payment.toJson()).toList(),
    );
  }
}
