import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance_tracker/utils/breakpoints.dart';
import 'package:personal_finance_tracker/controllers/payments_controller.dart';
import 'package:personal_finance_tracker/models/payment.dart';
import 'package:personal_finance_tracker/controllers/schedule_controller.dart';
import 'package:personal_finance_tracker/controllers/settings_controller.dart';
import 'package:personal_finance_tracker/views/forms/inputformatters/currency_input_formatter.dart';
import 'package:personal_finance_tracker/views/not_found_screen.dart';

class PaymentForm extends StatelessWidget {
  static final _formKey = GlobalKey<FormBuilderState>();
  final PaymentController controller;
  static final schedule = Get.find<ScheduleController>();
  final SettingsController settings = Get.find<SettingsController>();
  final Payment? payment;
  final bool edit;

  PaymentForm({super.key})
      : controller = Get.find<PaymentController>(),
        edit = false,
        payment = null;

  PaymentForm.edit({super.key})
      : controller = Get.find<PaymentController>(),
        payment = Get.find<PaymentController>().findById(Get.parameters["id"]),
        edit = true;

  PaymentForm.editScheduled({super.key})
      : controller = Get.find<ScheduleController>(),
        payment = Get.find<ScheduleController>().findById(Get.parameters["id"]),
        edit = true;

  _reset() {
    _formKey.currentState?.reset();
  }

  _submit() {
    if (_formKey.currentState!.saveAndValidate()) {
      if (!edit) {
        Payment payment = Payment(
            title: _formKey.currentState!.value['title'],
            sum: int.parse((_formKey.currentState!.value['sum'] as String)
                .replaceAll(RegExp(r'[^0-9−]'), '')
                .replaceAll('−', '-')),
            category: _formKey.currentState!.value['category'],
            date: _formKey.currentState!.value['date'],
            scheduled: _formKey.currentState!.value['scheduled']);
        controller.add(payment);
        if (payment.scheduled) {
          schedule.add(payment);
        }
      } else {
        controller.update(payment!.copyWith(
            id: payment!.id,
            title: _formKey.currentState!.value['title'],
            sum: int.parse((_formKey.currentState!.value['sum'] as String)
                .replaceAll(RegExp(r'[^0-9−]'), '')
                .replaceAll('−', '-')),
            category: _formKey.currentState!.value['category'],
            date: _formKey.currentState!.value['date'],
            scheduled: _formKey.currentState!.value['scheduled']));
      }
      _formKey.currentState?.reset();
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (payment == null && edit) {
      return const NotFoundScreen();
    } else {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey[100],
            shadowColor: Colors.black,
            elevation: 1,
            title:
                edit ? const Text("Edit Payment") : const Text("New Payment")),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: Breakpoints.mobileL),
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: FormBuilder(
              key: _formKey,
              child: ListView(children: [
                const SizedBox(height: 10),
                FormBuilderTextField(
                  name: 'title',
                  initialValue: payment?.title,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    }
                    return "Enter a title!";
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Payment title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                FormBuilderTextField(
                  name: 'sum',
                  initialValue: NumberFormat.currency(
                          locale: settings.locale, symbol: settings.currency)
                      .format((payment?.sum ?? -0) / 100),
                  inputFormatters: [
                    CurrencyInputFormatter(settings.locale, settings.currency)
                  ],
                  validator: (value) {
                    if (value != null &&
                        value !=
                            NumberFormat.currency(
                                    locale: settings.locale,
                                    symbol: settings.currency)
                                .format((payment?.sum ?? -0) / 100)) {
                      return null;
                    }
                    return "Enter a sum!";
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.attach_money),
                    hintText: 'Payment sum',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                FormBuilderDateTimePicker(
                  name: 'date',
                  initialValue: payment?.date,
                  format: DateFormat.yMEd(settings.locale).add_jm(),
                  validator: (value) {
                    if (value != null) {
                      return null;
                    }
                    return "Select a time and date!";
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today),
                    hintText: 'Select date',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                FormBuilderDropdown(
                  name: 'category',
                  initialValue: payment?.category ?? '',
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.category),
                    hintText: 'Select category',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    for (String category in settings.categories)
                      DropdownMenuItem(value: category, child: Text(category))
                  ],
                ),
                const SizedBox(height: 10),
                if (!edit)
                  FormBuilderCheckbox(
                    name: 'scheduled',
                    initialValue: false,
                    title: const Text('Monthly Payment'),
                  ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _reset,
                      child: const Text('Reset'),
                    ),
                    ElevatedButton(
                      onPressed: _submit,
                      child: const Text('Submit'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ]),
            ),
          ),
        ),
      );
    }
  }
}
