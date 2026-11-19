import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/views/home_screen.dart';
import 'package:personal_finance_tracker/views/payments_screen.dart';
import 'package:personal_finance_tracker/views/schedule_screen.dart';
import 'package:personal_finance_tracker/views/settings_screen.dart';

class AppCorePages {
  static const appBarHeadings = [
    Text('Home'),
    Text('Payment History'),
    Text('Payment Schedule'),
    Text('Settings'),
  ];

  static const appBarIcons = [
    Icon(
      Icons.home,
      size: 36.0,
    ),
    Icon(
      Icons.payments,
      size: 36.0,
    ),
    Icon(
      Icons.schedule,
      size: 36.0,
    ),
    Icon(
      Icons.settings,
      size: 36.0,
    ),
  ];

  static final body = [
    HomeScreen(),
    PaymentsScreen(),
    ScheduleScreen(),
    SettingsScreen(),
  ];

  static const navBarItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.payments,
      ),
      label: "Payments",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.schedule,
      ),
      label: "Schedule",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: "Settings",
    ),
  ];
}
