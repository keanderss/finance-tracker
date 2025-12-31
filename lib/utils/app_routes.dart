import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:personal_finance_tracker/views/app_core.dart';
import 'package:personal_finance_tracker/views/forms/payment_form.dart';

class AppRoutes {
  static const root = "/";
  static const addPayment = "/payments/add";
  static const editPayment = "/payments/edit";
  static const editSchedule = "/schedule/edit";

  static final getroutes = [
    GetPage(name: root, page: () => AppCore()),
    GetPage(name: addPayment, page: () => PaymentForm()),
    GetPage(name: "$editPayment/:id", page: () => PaymentForm.edit()),
    GetPage(name: "$editSchedule/:id", page: () => PaymentForm.editScheduled()),
  ];
}
