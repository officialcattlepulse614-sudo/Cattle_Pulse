import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:cattle_pulse/themes/theme_provider.dart'; 

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        // 🌈 Gradient Background (light and soft)
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 255, 255, 255), // natural green
              Color.fromARGB(255, 255, 255, 255), // lighter green
              Color.fromARGB(255, 255, 255, 255), // golden yellow
            ],
          ),
        ),
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(
                child: Image(
                  image: AssetImage("assets/images/cp.png"),
                  height: 80,
                ),
              ),
            ),
            const SizedBox(height: 10),

            DrawerListTile(
              title: "Dashboard",
              svgSrc: "assets/icons/dashboard.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Cattle Health",
              svgSrc: "assets/icons/cattle_health.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Feeding Schedule",
              svgSrc: "assets/icons/cfs.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Temperature Monitor",
              svgSrc: "assets/icons/Temperature.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Reports",
              svgSrc: "assets/icons/menu_store.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Notification",
              svgSrc: "assets/icons/menu_notification.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Profile",
              svgSrc: "assets/icons/menu_profile.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Settings",
              svgSrc: "assets/icons/menu_setting.svg",
              press: () {},
            ),

            const Divider(thickness: 1, height: 32),

            // 🌗 DARK MODE TOGGLE SECTION
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) {
                final isDark = themeProvider.isDarkMode;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              isDark ? Icons.light_mode : Icons.dark_mode,
                              color: isDark
                                  ? const Color(0xFFFFD700)
                                  : const Color(0xFF8AA29E),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isDark ? 'Light Mode ☀️' : 'Dark Mode 🌙',
                              style: TextStyle(
                                color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color ??
                                    Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.5,
                              ),
                            ),
                          ],
                        ),
                        Switch.adaptive(
                          activeColor: const Color(0xFFD4AF37),
                          value: isDark,
                          onChanged: (value) {
                            themeProvider.toggleTheme(value);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 📌 Drawer Tile Component
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
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: const ColorFilter.mode(
          Color.fromARGB(255, 0, 0, 0),
          BlendMode.srcIn,
        ),
        height: 18,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
