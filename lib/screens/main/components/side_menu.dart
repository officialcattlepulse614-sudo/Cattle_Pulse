import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
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

    final Gradient backgroundGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark
          ? [const Color(0xFF1B1A18), const Color(0xFF241E1A), const Color(0xFF2C1A12)]
          : [const Color(0xFFF9EBD4), const Color(0xFFF3E0C2), const Color(0xFFEBD1A3)],
    );

    return Drawer(
      width: size.width < 700 ? 240 : 300,
      child: Container(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withOpacity(0.3) : Colors.brown.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: size.width < 700 ? 12 : 20, vertical: 10),
          children: [
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
            _menuTile(context, tr('dashboard'), "assets/icons/dashboard.svg", menuController),
            _menuTile(context, tr('cattle_health'), "assets/icons/cattle_pulse.svg", menuController),
            _menuTile(context, tr('feeding_schedule'), "assets/icons/cfs.svg", menuController),
            _menuTile(context, tr('temperature_monitor'), "assets/icons/Temperature.svg", menuController),

            // 🩺 New Diseases menu
            _menuTile(context, tr('Diseases'), "assets/icons/health.svg", menuController),

            _menuTile(context, tr('reports'), "assets/icons/reports-icon.svg", menuController),
            _menuTile(context, tr('notifications'), "assets/icons/notification-icon.svg", menuController),
            _menuTile(context, tr('profile'), "assets/icons/profile-icon.svg", menuController),
            _menuTile(context, tr('settings'), "assets/icons/menu_setting.svg", menuController),

            const Divider(height: 25, thickness: 1.2),

            // 🌗 Theme toggle
            ValueListenableBuilder<ThemeMode>(
              valueListenable: themeNotifier,
              builder: (context, mode, _) {
                final isDarkMode = mode == ThemeMode.dark;
                final activeColor = isDarkMode
                    ? const Color(0xFFE29B4B)
                    : const Color(0xFFB87333);
                return SwitchListTile(
                  value: isDarkMode,
                  onChanged: (val) => themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light,
                  title: Text(
                    isDarkMode ? tr('dark_mode') : tr('light_mode'),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: activeColor,
                    ),
                  ),
                  secondary: Icon(
                    isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: activeColor,
                  ),
                  activeThumbColor: activeColor,
                  inactiveThumbColor: Colors.brown.shade300,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuTile(BuildContext context, String title, String iconPath, MenuAppController controller) {
    final iconColor = Theme.of(context).colorScheme.onSurface.withOpacity(0.9);
    return ListTile(
      onTap: () => controller.selectMenu(title),
      dense: true,
      horizontalTitleGap: 10,
      leading: SvgPicture.asset(
        iconPath,
        height: 20,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 15, fontWeight: FontWeight.w500),
      ),
    );
  }
}

