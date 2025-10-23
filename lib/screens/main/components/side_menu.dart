import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:cattle_pulse/controllers/menu_app_controller.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key, required this.themeNotifier}) : super(key: key);

  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final menuController = context.read<MenuAppController>();
    final size = MediaQuery.of(context).size;
    final bool isDark = theme.brightness == Brightness.dark;

    // 🎨 Shiny gradient background with soft gloss effect
    final Gradient backgroundGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark
          ? [
              const Color(0xFF1B1A18),
              const Color(0xFF241E1A),
              const Color(0xFF2C1A12),
            ]
          : [
              const Color(0xFFF9EBD4),
              const Color(0xFFF3E0C2),
              const Color(0xFFEBD1A3),
            ],
    );

    return Drawer(
      width: size.width < 700 ? 240 : 300, // smaller on mobile
      child: Container(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.brown.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width < 700 ? 12 : 20,
            vertical: 10,
          ),
          children: [
            // 🐮 Logo header - smaller & slightly upward
            DrawerHeader(
              margin: const EdgeInsets.only(bottom: 8, top: 4),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/cp2.png",
                  height: size.width < 700 ? 60 : 85,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 5),

            // 🧭 Menu items
            DrawerListTile(
              title: "Dashboard",
              svgSrc: "assets/icons/dashboard.svg",
              press: () => menuController.selectMenu("Dashboard"),
            ),
            DrawerListTile(
              title: "Cattle Health",
              svgSrc: "assets/icons/cattle_pulse.svg",
              press: () => menuController.selectMenu("Cattle Health"),
            ),
            DrawerListTile(
              title: "Feeding Schedule",
              svgSrc: "assets/icons/cfs.svg",
              press: () => menuController.selectMenu("Feeding Schedule"),
            ),
            DrawerListTile(
              title: "Temperature Monitor",
              svgSrc: "assets/icons/Temperature.svg",
              press: () => menuController.selectMenu("Temperature Monitor"),
            ),
            DrawerListTile(
              title: "Reports",
              svgSrc: "assets/icons/reports-icon.svg",
              press: () => menuController.selectMenu("Reports"),
            ),
            DrawerListTile(
              title: "Notification",
              svgSrc: "assets/icons/notification-icon.svg",
              press: () => menuController.selectMenu("Notification"),
            ),
            DrawerListTile(
              title: "Profile",
              svgSrc: "assets/icons/profile-icon.svg",
              press: () => menuController.selectMenu("Profile"),
            ),
            DrawerListTile(
              title: "Settings",
              svgSrc: "assets/icons/menu_setting.svg",
              press: () => menuController.selectMenu("Settings"),
            ),
            const Divider(height: 25, thickness: 1.2),

            // 🌗 Theme switch (Dark / Light)
            ValueListenableBuilder<ThemeMode>(
              valueListenable: themeNotifier,
              builder: (context, mode, child) {
                final isDarkMode = mode == ThemeMode.dark;
                final Color activeColor = isDarkMode
                    ? const Color(0xFFE29B4B)
                    : const Color(0xFFB87333);
                return SwitchListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  value: isDarkMode,
                  onChanged: (value) {
                    themeNotifier.value =
                        value ? ThemeMode.dark : ThemeMode.light;
                  },
                  title: Text(
                    isDarkMode ? "Dark Mode" : "Light Mode",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: activeColor,
                    ),
                  ),
                  secondary: Icon(
                    isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: activeColor,
                    size: 22,
                  ),
                  activeThumbColor: activeColor,
                  inactiveThumbColor: const Color(0xFFC43F1D),
                  inactiveTrackColor: const Color(0xFFE6C7A3),
                );
              },
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.colorScheme.onSurface.withOpacity(0.9);
    final textStyle = theme.textTheme.bodyLarge?.copyWith(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    );

    return ListTile(
      onTap: press,
      dense: true,
      horizontalTitleGap: 10.0, // adds spacing between icon & text
      minLeadingWidth: 24,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      leading: SvgPicture.asset(
        svgSrc,
        semanticsLabel: title,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        height: 20,
      ),
      title: Text(title, style: textStyle),
    );
  }
}
