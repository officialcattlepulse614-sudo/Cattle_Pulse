import 'package:cattle_pulse/controllers/menu_app_controller.dart';
import 'package:cattle_pulse/screens/main/components/side_menu.dart';
import 'package:cattle_pulse/screens/profile_screen/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const HomeScreen({super.key, required this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuAppController>(
      builder: (context, menuController, child) {
        final theme = Theme.of(context);
        final bool isDark = theme.brightness == Brightness.dark;

        // 🎨 Adaptive color scheme
        final Color titleColor = isDark
            ? const Color(0xFFEBD1A3) // warm beige for dark mode
            : const Color(0xFF2E2E2E); // charcoal for light mode

        final Color iconColor = isDark
            ? const Color(0xFFE29B4B) // amber for dark mode
            : const Color(0xFFB87333); // bronze for light mode

        return Scaffold(
          key: menuController.scaffoldKey,
          drawer: SideMenu(themeNotifier: themeNotifier),
          drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.12,

          // 🧭 App Bar
          appBar: AppBar(
            backgroundColor: isDark
                ? const Color(0xFF1F1B18) // deep black-brown tone
                : const Color(0xFFEADAC0), // soft beige tone
            elevation: 1,
            title: Text(
              menuController.selectedMenu,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.menu_rounded, color: iconColor),
              onPressed: menuController.controlMenu,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ProfileMenu(
                  iconColor: iconColor,
                  themeNotifier: themeNotifier,
                ),
              ),
            ],
          ),

          // 🧱 Main Content
          body: SafeArea(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: menuController.currentScreen,
            ),
          ),
        );
      },
    );
  }
}
