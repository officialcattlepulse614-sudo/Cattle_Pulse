// lib/screens/menu_screens/settings_screen/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cattle_pulse/screens/side_menu_screens/settings_screen/theme_appearance.dart';
import 'package:cattle_pulse/screens/side_menu_screens/settings_screen/language_screen.dart';
import 'package:cattle_pulse/screens/side_menu_screens/settings_screen/help_support.dart';
import 'package:cattle_pulse/screens/side_menu_screens/settings_screen/about_app_screen.dart';
import 'package:cattle_pulse/screens/side_menu_screens/settings_screen/privacy_security_screen.dart';
import 'package:cattle_pulse/screens/side_menu_screens/settings_screen/notification_screen/notification_screen.dart';
import 'package:cattle_pulse/screens/side_menu_screens/settings_screen/notification_screen/notification_provider.dart';
import 'package:cattle_pulse/widgets/screen_wrapper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarIconBrightness:
          isDark ? Brightness.light : Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ScreenWrapper(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 5),

              // Notification Settings
              _buildCenteredCardTile(
                context,
                icon: Icons.notifications_active_outlined,
                title: "Notification Settings",
                subtitle: "Manage how you get alerts and updates",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider(
                        create: (_) => NotificationSettings(),
                        child: NotificationScreen(),
                      ),
                    ),
                  );
                },
                isDark: isDark,
              ),

              const SizedBox(height: 25),

              // Theme / Appearance
              _buildCenteredCardTile(
                context,
                icon: Icons.color_lens_outlined,
                title: "Theme / Appearance",
                subtitle: "Change Theme & Manage fonts",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ThemeAppearance()),
                  );
                },
                isDark: isDark,
              ),

              const SizedBox(height: 25),

              // Language
              _buildCenteredCardTile(
                context,
                icon: Icons.language_outlined,
                title: "Language",
                subtitle: "Select your preferred language",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LanguageScreen()),
                  );
                },
                isDark: isDark,
              ),

              const SizedBox(height: 25),

              // Privacy & Security
              _buildCenteredCardTile(
                context,
                icon: Icons.lock_outline,
                title: "Privacy & Security",
                subtitle: "Control data, permissions, and privacy policies",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const PrivacySecurityScreen()),
                  );
                },
                isDark: isDark,
              ),

              const SizedBox(height: 25),

              // Help & Support
              _buildCenteredCardTile(
                context,
                icon: Icons.help_outline,
                title: "Help & Support",
                subtitle: "Get assistance and read FAQs",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HelpSupportScreen()),
                  );
                },
                isDark: isDark,
              ),

              const SizedBox(height: 25),

              // About App
              _buildCenteredCardTile(
                context,
                icon: Icons.info_outline,
                title: "About App",
                subtitle: "Learn about Cattle Pulse features",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AboutAppScreen()),
                  );
                },
                isDark: isDark,
              ),

              const SizedBox(height: 40),
              _buildFooterNote(isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCenteredCardTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.88,
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF1E1E1E)
              : const Color.fromARGB(255, 248, 234, 220),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black45 : Colors.grey.withOpacity(0.25),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF2C2C2C)
                  : const Color(0xFFEADAC0).withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(icon,
                color:
                    isDark ? const Color(0xFFE29B4B) : const Color(0xFFB87333)),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: isDark ? Colors.white60 : Colors.grey[700],
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios_rounded,
              size: 16, color: isDark ? Colors.white54 : Colors.grey[600]),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _buildFooterNote(bool isDark) {
    return Center(
      child: Text(
        "Cattle Pulse © 2025",
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          color: isDark ? Colors.white38 : Colors.grey[600],
        ),
      ),
    );
  }
}
