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

    final Gradient backgroundGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        theme.scaffoldBackgroundColor,
        Color.alphaBlend(
          theme.brightness == Brightness.dark
              ? Colors.white.withOpacity(0.02)
              : Colors.black.withOpacity(0.02),
          theme.scaffoldBackgroundColor,
        ),
      ],
    );

    return Drawer(
      child: SizedBox(
        width: 300,
        child: Container(
          decoration: BoxDecoration(gradient: backgroundGradient),
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Image.asset(
                    "assets/images/cp.png",
                    height: 80,
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
              const Divider(),
              ValueListenableBuilder<ThemeMode>(
                valueListenable: themeNotifier,
                builder: (context, mode, child) {
                  final isDark = mode == ThemeMode.dark;
                  return SwitchListTile(
                    value: isDark,
                    onChanged: (value) {
                      themeNotifier.value =
                          value ? ThemeMode.dark : ThemeMode.light;
                    },
                    title: Text(
                      isDark ? "Dark Mode" : "Light Mode",
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    secondary:
                        Icon(isDark ? Icons.dark_mode : Icons.light_mode),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
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
    final iconColor = theme.colorScheme.onBackground;
    final textStyle = theme.textTheme.bodyLarge
        ?.copyWith(fontSize: 15, fontWeight: FontWeight.w500);

    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        semanticsLabel: title,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        height: 18,
      ),
      title: Text(title, style: textStyle),
    );
  }
}
