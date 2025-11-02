import 'package:flutter/material.dart';
import 'package:cattle_pulse/screens/auth/login_screen.dart';
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

    // Listen to controller so avatar updates when image changes
    final menuController = Provider.of<MenuAppController>(context);

    return PopupMenuButton<int>(
      // Circle avatar as popup icon (updates when profile image changes)
      icon: CircleAvatar(
        radius: 18,
        backgroundImage: menuController.profileImageProvider,
        backgroundColor: isDark
            ? Colors.grey[800]
            : const Color.fromARGB(255, 238, 238, 238),
      ),

      offset: const Offset(0, 45),

      // 🎨 Popup background color
      color: isDark
          ? const Color(0xFF3A3A3A) // soft dark grey for dark mode
          : const Color.fromARGB(
              255, 255, 236, 184), // golden yellow for light mode

      // ✨ Popup shape & border styling
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isDark
              ? Colors.white24
              : const Color(0xFFB87333).withOpacity(0.4), // bronze tint border
          width: 1.2,
        ),
      ),

      onSelected: (value) {
        switch (value) {
          case 0: // Profile
            menuController.updateMenu("Profile");
            break;
          case 1: // Settings
            menuController.updateMenu("Settings");
            break;
          case 2: // Toggle theme
            themeNotifier.value = themeNotifier.value == ThemeMode.light
                ? ThemeMode.dark
                : ThemeMode.light;
            break;
          case 3: // Logout
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
                    fontWeight: FontWeight.w500),
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
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Row(
            children: [
              Icon(
                themeNotifier.value == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
                size: 20,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
              const SizedBox(width: 10),
              Text(
                themeNotifier.value == ThemeMode.light
                    ? "Dark Mode"
                    : "Light Mode",
                style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black87,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<int>(
          value: 3,
          child: Row(
            children: const [
              Icon(Icons.logout, size: 20, color: Colors.redAccent),
              SizedBox(width: 10),
              Text("Logout",
                  style: TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}
