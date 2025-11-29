import 'package:flutter/material.dart';
import 'package:cattle_pulse/screens/auth/login_screen.dart';
import 'package:cattle_pulse/controllers/menu_app_controller.dart';
import 'package:cattle_pulse/controllers/theme_provider.dart';
import 'package:provider/provider.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Listen to controllers
    final menuController = Provider.of<MenuAppController>(context);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Center(
      child: PopupMenuButton<int>(
        padding: EdgeInsets.zero,
        offset: const Offset(0, 48),

        // Circle avatar as popup icon (updates when profile image changes)
        icon: CircleAvatar(
          radius: 24,
          backgroundColor:
              isDark ? const Color(0xFF1F1B18) : const Color(0xFFE6DAC6),
          backgroundImage: menuController.profileImageProvider,
          child: null,
        ),

        // Popup background color
        color: isDark ? const Color(0xFF1F1B18) : const Color(0xFFE6DAC6),

        // Popup shape & border styling
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: isDark ? const Color(0xFF302518) : const Color(0xFFA89B85),
            width: 1.8,
          ),
        ),

        onSelected: (value) {
          switch (value) {
            case 0:
              menuController.updateMenu("Profile");
              break;

            case 1:
              menuController.updateMenu("Settings");
              break;

            case 2:
              // Toggle theme using ThemeProvider
              if (isDark) {
                themeProvider.setTheme(ThemeMode.light);
              } else {
                themeProvider.setTheme(ThemeMode.dark);
              }
              break;

            case 3:
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
                Icon(
                  Icons.person,
                  size: 20,
                  color: isDark
                      ? const Color(0xFFE29B4B)
                      : const Color(0xFFB87333),
                ),
                const SizedBox(width: 10),
                Text(
                  "Profile",
                  style: TextStyle(
                    color: isDark
                        ? const Color(0xFFF5E6C8)
                        : const Color(0xFF3B2E1A),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 1,
            child: Row(
              children: [
                Icon(
                  Icons.settings,
                  size: 20,
                  color: isDark
                      ? const Color(0xFFE29B4B)
                      : const Color(0xFFB87333),
                ),
                const SizedBox(width: 10),
                Text(
                  "Settings",
                  style: TextStyle(
                    color: isDark
                        ? const Color(0xFFF5E6C8)
                        : const Color(0xFF3B2E1A),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 2,
            child: Row(
              children: [
                Icon(
                  isDark ? Icons.light_mode : Icons.dark_mode,
                  size: 20,
                  color: isDark
                      ? const Color(0xFFE29B4B)
                      : const Color(0xFFB87333),
                ),
                const SizedBox(width: 10),
                Text(
                  isDark ? "Light Mode" : "Dark Mode",
                  style: TextStyle(
                    color: isDark
                        ? const Color(0xFFF5E6C8)
                        : const Color(0xFF3B2E1A),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuDivider(
            height: 1,
          ),
          PopupMenuItem<int>(
            value: 3,
            child: Row(
              children: const [
                Icon(Icons.logout, size: 20, color: Colors.redAccent),
                SizedBox(width: 10),
                Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
