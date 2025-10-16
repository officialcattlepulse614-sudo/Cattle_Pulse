import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:cattle_pulse/themes/theme_provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF1B5E20),
                    const Color(0xFF2E7D32),
                    const Color(0xFF3E2723),
                  ]
                : [
                    const Color(0xFF81C784),
                    const Color(0xFFAED581),
                    const Color(0xFFFFD54F),
                  ],
          ),
        ),
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Image.asset(
                  "assets/images/cp.png",
                  height: 90,
                  color: isDark ? Colors.white : null,
                ),
              ),
            ),
            const SizedBox(height: 10),
            DrawerListTile(
              title: "Dashboard",
              svgSrc: "assets/icons/dashboard.svg",
              press: () {},
              isDark: isDark,
            ),
            DrawerListTile(
              title: "Cattle Health",
              svgSrc: "assets/icons/cattle_health.svg",
              press: () {},
              isDark: isDark,
            ),
            DrawerListTile(
              title: "Feeding Schedule",
              svgSrc: "assets/icons/cfs.svg",
              press: () {},
              isDark: isDark,
            ),
            DrawerListTile(
              title: "Temperature Monitor",
              svgSrc: "assets/icons/Temperature.svg",
              press: () {},
              isDark: isDark,
            ),
            DrawerListTile(
              title: "Reports",
              svgSrc: "assets/icons/menu_store.svg",
              press: () {},
              isDark: isDark,
            ),
            DrawerListTile(
              title: "Notification",
              svgSrc: "assets/icons/menu_notification.svg",
              press: () {},
              isDark: isDark,
            ),
            DrawerListTile(
              title: "Profile",
              svgSrc: "assets/icons/menu_profile.svg",
              press: () {},
              isDark: isDark,
            ),
            DrawerListTile(
              title: "Settings",
              svgSrc: "assets/icons/menu_setting.svg",
              press: () {},
              isDark: isDark,
            ),

            const Divider(thickness: 1, height: 32),

            // 🌗 Dark Mode Switch
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) {
                final isDark = themeProvider.isDarkMode;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF2E7D32)
                          : const Color(0xFFFFF8E1),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? Colors.black.withOpacity(0.4)
                              : Colors.green.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(2, 3),
                        ),
                      ],
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              isDark
                                  ? Icons.dark_mode_rounded
                                  : Icons.light_mode_rounded,
                              color: isDark
                                  ? const Color(0xFFFFD54F)
                                  : const Color(0xFF2E7D32),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isDark ? 'Dark Mode' : 'Light Mode',
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Switch.adaptive(
                          activeColor: const Color(0xFFFFD54F),
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

class DrawerListTile extends StatelessWidget {
  final String title, svgSrc;
  final VoidCallback press;
  final bool isDark;

  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 10.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(
          isDark ? Colors.white : Colors.black,
          BlendMode.srcIn,
        ),
        height: 20,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
