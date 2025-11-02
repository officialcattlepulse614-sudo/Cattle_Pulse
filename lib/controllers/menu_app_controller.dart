// menu_app_controller.dart
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// -------------------------------
// Menu Screens (Dashboard & Core)
// -------------------------------
import 'package:cattle_pulse/screens/menu_screens/dashboard_screen/dashboard_screen.dart';
import 'package:cattle_pulse/screens/menu_screens/geofencing_screen/geofencing_screen.dart';

// -------------------------------
// Cattle Health
// -------------------------------
import 'package:cattle_pulse/screens/menu_screens/cattle_health/diagnosis_treatment_screen.dart';
import 'package:cattle_pulse/screens/menu_screens/cattle_health/temperature_monitor_screen.dart';
import 'package:cattle_pulse/screens/menu_screens/cattle_health/vaccination_records_screen.dart';

// -------------------------------
// Cattle Feeding
// -------------------------------
import 'package:cattle_pulse/screens/menu_screens/cattle_feeding/feeding_schedule_screen.dart';
import 'package:cattle_pulse/screens/menu_screens/cattle_feeding/autofeeder_screen.dart';
import 'package:cattle_pulse/screens/menu_screens/cattle_feeding/inventory_screen.dart';

// -------------------------------
// Reports / Settings / Profile
// -------------------------------
import 'package:cattle_pulse/screens/menu_screens/reports_screen/reports_screen.dart';
import 'package:cattle_pulse/screens/menu_screens/settings_screen/settings_screen.dart';
import 'package:cattle_pulse/screens/menu_screens/profile_screen/profile_screen.dart';

class MenuAppController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  String _selectedMenu = "Dashboard";
  String get selectedMenu => _selectedMenu;

  Widget _currentScreen = const DashboardScreen();
  Widget get currentScreen => _currentScreen;

  final ValueNotifier<int> unreadNotifications = ValueNotifier<int>(0);

  File? _profileImage;
  Uint8List? _profileImageBytes;
  String? _profileImagePath;
  String? _userName = "Admin User";

  File? get profileImage => _profileImage;
  Uint8List? get profileImageBytes => _profileImageBytes;
  String get userName => _userName ?? "Admin User";
  String? get profileImagePath => _profileImagePath;

  ImageProvider<Object> get profileImageProvider {
    if (!kIsWeb && _profileImage != null) {
      try {
        return FileImage(_profileImage!);
      } catch (_) {}
    }
    if (_profileImageBytes != null) {
      return MemoryImage(_profileImageBytes!);
    }
    return const AssetImage('assets/images/default_avatar.jpeg');
  }

  bool get hasCustomProfilePicture =>
      _profileImage != null ||
      _profileImageBytes != null ||
      _profileImagePath != null;

  bool get isProfileScreen => _selectedMenu == "Profile";

  MenuAppController() {
    _loadProfileData();
  }

  // ------------------------
  // Navigation helper
  // ------------------------
  void updateMenu(String menuName) => selectMenu(menuName);

  void selectMenu(String menuName) {
    final matched = _menuLabels.firstWhere(
      (m) => m.toLowerCase() == menuName.toLowerCase(),
      orElse: () => menuName,
    );

    _selectedMenu = matched;

    switch (matched) {
      case "Dashboard":
        _currentScreen = const DashboardScreen();
        break;
      case "Profile":
        _currentScreen = const ProfileScreen();
        break;
      case "Temperature Monitor":
        _currentScreen = const TemperatureMonitorScreen();
        break;
      case "Diagnosis & Treatment":
        _currentScreen = const DiagnosisTreatmentScreen();
        break;
      case "Vaccination & Records":
        _currentScreen = const VaccinationRecordsScreen();
        break;
      case "Feeding Schedule":
        _currentScreen = const FeedingScheduleScreen();
        break;
      case "Auto Feeder":
        _currentScreen = const AutofeederScreen();
        break;
      case "Inventory":
        _currentScreen = const InventoryScreen();
        break;
      case "Geo Fencing":
        _currentScreen = const GeofencingScreen();
        break;
      case "Reports":
        _currentScreen = const ReportsScreen();
        break;
      case "Settings":
        _currentScreen = const SettingsScreen();
        break;
      default:
        _currentScreen = const DashboardScreen();
        _selectedMenu = "Dashboard";
        break;
    }

    notifyListeners();
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      _scaffoldKey.currentState!.closeDrawer();
    }
  }

  // ------------------------
  // Profile persistence (mobile & web)
  // ------------------------
  Future<void> _loadProfileData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final savedName = prefs.getString('user_name');
      if (savedName != null && savedName.isNotEmpty) {
        _userName = savedName;
      }

      final path = prefs.getString('profile_image_path');
      if (path != null && path.isNotEmpty && !kIsWeb) {
        final f = File(path);
        if (f.existsSync()) {
          _profileImage = f;
          _profileImagePath = path;
        }
      }

      final base64Str = prefs.getString('profile_image_base64');
      if (base64Str != null && base64Str.isNotEmpty) {
        try {
          _profileImageBytes = base64Decode(base64Str);
        } catch (_) {
          _profileImageBytes = null;
        }
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading profile data: $e');
    }
  }

  /// ✅ Unified profile update function.
  ///
  /// Compatible with both old and new param names.
  Future<void> updateProfile({
    File? imageFile,
    File? image, // alias for backward compatibility
    Uint8List? imageBytes,
    Uint8List? bytes, // alias for backward compatibility
    String? name,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final file = imageFile ?? image;
      final byteData = imageBytes ?? bytes;

      if (!kIsWeb && file != null) {
        _profileImage = file;
        _profileImagePath = file.path;
        await prefs.setString('profile_image_path', file.path);
        _profileImageBytes = null;
        await prefs.remove('profile_image_base64');
      } else if (kIsWeb && byteData != null) {
        _profileImageBytes = byteData;
        final b64 = base64Encode(byteData);
        await prefs.setString('profile_image_base64', b64);
        _profileImage = null;
        await prefs.remove('profile_image_path');
      }

      if (name != null && name.trim().isNotEmpty) {
        _userName = name.trim();
        await prefs.setString('user_name', _userName!);
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error updating profile: $e');
    }
  }

  Future<void> resetProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('profile_image_path');
      await prefs.remove('profile_image_base64');
      await prefs.remove('user_name');

      _profileImage = null;
      _profileImageBytes = null;
      _profileImagePath = null;
      _userName = "Admin User";

      notifyListeners();
    } catch (e) {
      debugPrint('Error resetting profile: $e');
    }
  }

  // ------------------------
  // Helpers / other code
  // ------------------------
  final List<String> _menuLabels = [
    'Dashboard',
    'Profile',
    'Cattle Health',
    'Temperature Monitor',
    'Diagnosis & Treatment',
    'Vaccination & Records',
    'Cattle Feeding',
    'Feeding Schedule',
    'Auto Feeder',
    'Inventory',
    'Geo Fencing',
    'Reports',
    'Settings',
  ];

  final Map<String, List<String>> _groupChildren = {
    'Cattle Health': [
      'Temperature Monitor',
      'Diagnosis & Treatment',
      'Vaccination & Records',
    ],
    'Cattle Feeding': [
      'Feeding Schedule',
      'Auto Feeder',
      'Inventory',
    ],
  };

  void controlMenu() {
    if (!(_scaffoldKey.currentState?.isDrawerOpen ?? false)) {
      _scaffoldKey.currentState?.openDrawer();
    }
  }

  void searchMenu(String query) {
    if (query.trim().isEmpty) return;
    final q = query.trim().toLowerCase();

    final exact = _menuLabels.firstWhere(
      (m) => m.toLowerCase() == q,
      orElse: () => '',
    );
    if (exact.isNotEmpty) return selectMenu(exact);

    final starts = _menuLabels.firstWhere(
      (m) => m.toLowerCase().startsWith(q),
      orElse: () => '',
    );
    if (starts.isNotEmpty) return selectMenu(starts);

    final contains = _menuLabels.firstWhere(
      (m) => m.toLowerCase().contains(q),
      orElse: () => '',
    );
    if (contains.isNotEmpty) return selectMenu(contains);
  }

  void incrementUnread([int by = 1]) {
    unreadNotifications.value += by;
  }

  void clearUnread() {
    unreadNotifications.value = 0;
  }

  bool isInGroup(String groupLabel) {
    final children = _groupChildren[groupLabel];
    if (children == null) return false;
    return children.contains(_selectedMenu);
  }

  @override
  void dispose() {
    unreadNotifications.dispose();
    super.dispose();
  }
}
