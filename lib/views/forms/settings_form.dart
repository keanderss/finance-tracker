import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/controllers/core_controller.dart';
import 'package:personal_finance_tracker/models/settings.dart';
import 'package:personal_finance_tracker/utils/breakpoints.dart';
import 'package:personal_finance_tracker/controllers/settings_controller.dart';
import 'package:personal_finance_tracker/utils/locale.dart';

class SettingsForm extends StatelessWidget {
  static final _formKey = GlobalKey<FormBuilderState>();
  final SettingsController controller = Get.find<SettingsController>();
  final CoreController core = Get.find<CoreController>();
  late final RxSet<String> categories;

  SettingsForm({super.key}) {
    categories = controller.categories.obs;
  }

  _submit() {
    if (_formKey.currentState!.saveAndValidate()) {
      Settings settings = controller.settings.value;
      controller.update(
        settings.copyWith(
          locale: _formKey.currentState!.value['locale'],
          currency: _formKey.currentState!.value['currency'],
          categories: categories.toJson(),
        ),
      );
      core.animateToPage(0,
          duration: const Duration(milliseconds: 1), curve: Curves.linear);
    }
  }

  _addCategory() {
    _formKey.currentState!.save();
    String newCategory = _formKey.currentState?.value['categories'];
    if (newCategory.isNotEmpty) {
      categories.add(newCategory);
    }
    _formKey.currentState?.fields['categories']?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: Breakpoints.mobileL),
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: FormBuilder(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text("Locale"),
                    ),
                    FormBuilderDropdown(
                      name: 'locale',
                      initialValue: controller.locale,
                      items: <DropdownMenuItem>[
                        for (MapEntry<String, String> entry
                            in Locale.locales.entries)
                          DropdownMenuItem(
                              value: entry.value, child: Text(entry.key))
                      ],
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.map),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text("Currency"),
                    ),
                    FormBuilderDropdown(
                      name: 'currency',
                      initialValue: controller.currency,
                      items: <DropdownMenuItem>[
                        for (MapEntry<String, String> entry
                            in Locale.currencies.entries)
                          DropdownMenuItem(
                              value: entry.value, child: Text(entry.key))
                      ],
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: ElevatedButton(
                        onPressed: _submit,
                        child: const Text('Save'),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text("Edit Categories"),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: FormBuilderTextField(
                            name: 'categories',
                            initialValue: '',
                            validator: (value) {
                              if (categories.isEmpty) {
                                return "Add atleast one category!";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.category),
                              hintText: 'Add category',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5, bottom: 10),
                          child: ElevatedButton(
                            onPressed: _addCategory,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              fixedSize: const Size.square(48),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Obx(
                () => SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      for (String category in categories.toList())
                        Card(
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 20, top: 10, bottom: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(category),
                                IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                    onPressed: () =>
                                        categories.remove(category))
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
