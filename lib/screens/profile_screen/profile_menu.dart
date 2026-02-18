import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cattle_pulse/controllers/menu_app_controller.dart';
import 'package:cattle_pulse/controllers/theme_provider.dart';
import 'package:provider/provider.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  // ✅ Proper logout function with Firebase sign out
  Future<void> _handleLogout(BuildContext context) async {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Show confirmation dialog
    final shouldLogout = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isDark ? const Color(0xFF302518) : const Color(0xFFA89B85),
            width: 1.8,
          ),
        ),
        backgroundColor:
            isDark ? const Color(0xFF1F1B18) : const Color(0xFFE6DAC6),
        title: Row(
          children: [
            Icon(
              Icons.logout,
              color: Colors.redAccent,
            ),
            const SizedBox(width: 8),
            Text(
              "Logout",
              style: TextStyle(
                color:
                    isDark ? const Color(0xFFF5E6C8) : const Color(0xFF3B2E1A),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          "Are you sure you want to logout?",
          style: TextStyle(
            color: isDark ? const Color(0xFFF5E6C8) : const Color(0xFF3B2E1A),
            height: 1.4,
          ),
        ),
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor:
                  isDark ? const Color(0xFFE29B4B) : const Color(0xFFB87333),
            ),
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              "Cancel",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              "Logout",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );

    // If user confirmed logout
    if (shouldLogout == true) {
      try {
        // ✅ Sign out from Firebase
        await FirebaseAuth.instance.signOut();

        // ✅ AuthGate will automatically detect the sign out
        // and navigate to LoginScreen via StreamBuilder
      } catch (e) {
        // Show error if logout fails
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor:
                  isDark ? const Color(0xFF1F1B18) : const Color(0xFFE6DAC6),
              content: Text(
                "Logout failed. Please try again.",
                style: TextStyle(
                  color: isDark
                      ? const Color(0xFFF5E6C8)
                      : const Color(0xFF3B2E1A),
                ),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    }
  }

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
              // ✅ Call proper logout function
              _handleLogout(context);
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
          const PopupMenuDivider(
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
