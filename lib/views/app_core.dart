import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/core_controller.dart';
import '../utils/app_core_pages.dart';

class AppCore extends StatelessWidget {
  final controller = Get.find<CoreController>();

  AppCore({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[100],
            shadowColor: Colors.black,
            title: IndexedStack(
                index: controller.currentIndex.value,
                children: AppCorePages.appBarHeadings),
            leading: Center(
              child: IndexedStack(
                  index: controller.currentIndex.value,
                  children: AppCorePages.appBarIcons),
            ),
          ),
          body: PageView(
              controller: controller,
              onPageChanged: (index) => {controller.setIndex(index)},
              children: AppCorePages.body),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
              onTap: (index) => (controller.animateToPage(index,
                  duration: const Duration(milliseconds: 1),
                  curve: Curves.linear)),
              currentIndex: controller.currentIndex.value,
              items: AppCorePages.navBarItems),
        ),
      ),
    );
  }
}
