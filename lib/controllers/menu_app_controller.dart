import 'package:flutter/material.dart';

// Screens
import 'package:cattle_pulse/screens/dashboard/dashboard_screen.dart';
import 'package:cattle_pulse/screens/cattle_health_screen/cattle_health_screen.dart';
import 'package:cattle_pulse/screens/reports_screen/reports_screen.dart';
import 'package:cattle_pulse/screens/settings_screen/settings_screen.dart';
import 'package:cattle_pulse/screens/notification_screen/notification_screen.dart';
import 'package:cattle_pulse/screens/profile_screen/profile_screen.dart';
import 'package:cattle_pulse/screens/feeding_schedule_screen/feeding_schedule_screen.dart';
import 'package:cattle_pulse/screens/temperature_monitor_screen/temperature_monitor_screen.dart';
import 'package:cattle_pulse/screens/disease_screen/disease_screen.dart';

class MenuAppController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  // 🧭 Track selected menu
  String _selectedMenu = "Dashboard";
  String get selectedMenu => _selectedMenu;

  // 🧱 Current active screen
  Widget _currentScreen = const DashboardScreen();
  Widget get currentScreen => _currentScreen;

  // ✅ Helper used in both SideMenu & ProfileMenu
  void updateMenu(String menuName) => selectMenu(menuName);

  // 🚀 Screen routing logic
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

      case "Diseases":
      case "Cattle Diseases":
        _currentScreen = const DiseaseScreen();
        break;

      case "Reports":
        _currentScreen = const ReportsScreen();
        break;

      case "Notification":
      case "Notifications":
        _currentScreen = const NotificationScreen();
        break;

      case "Profile":
        _currentScreen = const ProfileScreen();
        break;

      case "Settings":
        _currentScreen = const SettingsScreen();
        break;

      default:
        _currentScreen = const DashboardScreen();
        break;
    }

    notifyListeners();

    // Automatically close drawer after selection
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      _scaffoldKey.currentState!.closeDrawer();
    }
  }

  // 🔘 Toggle drawer visibility
  void controlMenu() {
    if (!(_scaffoldKey.currentState?.isDrawerOpen ?? false)) {
      _scaffoldKey.currentState?.openDrawer();
    } else {
      _scaffoldKey.currentState?.closeDrawer();
    }
  }
}

