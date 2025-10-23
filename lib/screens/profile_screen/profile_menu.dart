import 'package:flutter/material.dart';
import 'package:cattle_pulse/screens/auth/login_screen.dart';
import 'package:cattle_pulse/screens/main/components/side_menu.dart';
import 'package:cattle_pulse/controllers/menu_app_controller.dart';
import 'package:provider/provider.dart';

class ProfileMenu extends StatelessWidget {
  final Color iconColor;
  final ValueNotifier<ThemeMode> themeNotifier;

  const ProfileMenu({
    super.key,
    required this.iconColor,
    required this.themeNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return PopupMenuButton<int>(
      icon: Icon(Icons.account_circle, color: iconColor, size: 32),
      offset: const Offset(0, 45),
      color: isDark ? const Color(0xFF2B2B2B) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) {
        switch (value) {
          case 0: // 🧍‍♂️ Profile
            // Use Provider to update the SideMenu’s active section to “Profile”
            final menuController =
                Provider.of<MenuAppController>(context, listen: false);
            menuController.updateMenu("Profile");
            break;

          case 1: // ⚙️ Settings
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Settings coming soon!")),
            );
            break;

          case 2: // 🚪 Logout
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: [
              Icon(Icons.person,
                  size: 20, color: isDark ? Colors.white70 : Colors.black87),
              const SizedBox(width: 10),
              Text(
                "Profile",
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: [
              Icon(Icons.settings,
                  size: 20, color: isDark ? Colors.white70 : Colors.black87),
              const SizedBox(width: 10),
              Text(
                "Settings",
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<int>(
          value: 2,
          child: Row(
            children: const [
              Icon(Icons.logout, size: 20, color: Colors.redAccent),
              SizedBox(width: 10),
              Text(
                "Logout",
                style: TextStyle(color: Colors.redAccent),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
