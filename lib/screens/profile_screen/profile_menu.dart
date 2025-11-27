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

    return Center(
      child: PopupMenuButton<int>(
        padding: EdgeInsets.zero, // ensures perfect centering
        offset: const Offset(0, 48),

        // Circle avatar as popup icon (updates when profile image changes)
        icon: CircleAvatar(
          radius: 24, // 🔥 bigger icon size
          backgroundColor: isDark
              ? Colors.grey[800]
              : const Color.fromARGB(255, 238, 238, 238),

          // 🔥 Your required line (kept exactly)
          backgroundImage: menuController.profileImageProvider,

          // Fallback icon when no profile image is available
          child: null,
        ),

        // 🎨 Popup background color
        color: isDark
            ? const Color(0xFF2A2A2A) // Deep elegant dark surface
            : const Color(0xFFFFF8E7), // Matches your light theme surface

        // ✨ Popup shape & border styling
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: isDark
                ? Colors.white24
                : const Color.fromARGB(255, 255, 197, 144).withOpacity(0.4),
            width: 1.2,
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
              themeNotifier.value = themeNotifier.value == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
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
      ),
    );
  }
}
