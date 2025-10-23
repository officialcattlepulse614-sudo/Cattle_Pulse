import 'package:flutter/material.dart';
import 'package:cattle_pulse/screens/dashboard/dashboard_screen.dart';
import 'package:cattle_pulse/screens/cattle_health_screen/cattle_health_screen.dart';
import 'package:cattle_pulse/screens/reports_screen/reports_screen.dart';
import 'package:cattle_pulse/screens/settings_screen/settings_screen.dart';
import 'package:cattle_pulse/screens/notification_screen/notification_screen.dart';
import 'package:cattle_pulse/screens/profile_screen/profile_screen.dart';
import 'package:cattle_pulse/screens/feeding_schedule_screen/feeding_schedule_screen.dart';
import 'package:cattle_pulse/screens/temperature_monitor_screen/temperature_monitor_screen.dart';

class MenuAppController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  // Track selected menu
  String _selectedMenu = "Dashboard";
  String get selectedMenu => _selectedMenu;

  // Track which screen widget is active
  Widget _currentScreen = const DashboardScreen();
  Widget get currentScreen => _currentScreen;

  // ✅ Helper for both Side Menu & ProfileMenu
  void updateMenu(String menuName) => selectMenu(menuName);

  void selectMenu(String menuName) {
    _selectedMenu = menuName;

    switch (menuName) {
      case "Dashboard":
        _currentScreen = const DashboardScreen();
        break;
      case "Cattle Health":
        _currentScreen = const CattleHealthScreen();
        break;
      case "Feeding Schedule":
        _currentScreen = const FeedingScheduleScreen();
        break;
      case "Temperature Monitor":
        _currentScreen = const TemperatureMonitorScreen();
        break;
      case "Reports":
        _currentScreen = const ReportsScreen();
        break;
      case "Notification":
        _currentScreen = const NotificationScreen();
        break;
      case "Profile":
        _currentScreen = const ProfileScreen();
        break;
      case "Settings":
        _currentScreen = const SettingsScreen();
        break;
    }

    notifyListeners();

    // Close drawer automatically if open
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      _scaffoldKey.currentState!.closeDrawer();
    }
  }

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}
