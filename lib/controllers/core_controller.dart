import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoreController extends PageController {
  final currentIndex = 0.obs;

  void setIndex(index) {
    currentIndex.value = index;
  }
}
