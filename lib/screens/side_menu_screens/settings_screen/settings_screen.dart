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
import 'package:lucide_icons/lucide_icons.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),

                  // Header Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 1),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF1F1B18)
                                    : const Color(0xFFE6DAC6),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isDark
                                      ? const Color(0xFF302518)
                                      : const Color(0xFFA89B85),
                                  width: 1.8,
                                ),
                              ),
                              child: Icon(
                                Icons.settings_suggest_rounded,
                                size: 28,
                                color: isDark
                                    ? const Color(0xFFE29B4B)
                                    : const Color(0xFFB87333),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    'Customize Your App Experience',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: isDark
                                          ? const Color(0xFFF5E6C8)
                                          : const Color(0xFF3B2E1A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Container(
                              width: 4,
                              height: 20,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFFE29B4B)
                                    : const Color(0xFFB87333),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'PREFERENCES',
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                                color: isDark
                                    ? const Color(0xFFF5E6C8).withOpacity(0.8)
                                    : const Color(0xFF3B2E1A).withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Settings Cards
                  _SettingsCard(
                    icon: LucideIcons.bell,
                    title: "Notification Settings",
                    subtitle: "Manage alerts and updates",
                    isDark: isDark,
                    delay: 0,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider(
                            create: (_) => NotificationSettings(),
                            child: const NotificationScreen(),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  _SettingsCard(
                    icon: LucideIcons.palette,
                    title: "Theme & Appearance",
                    subtitle: "Change App Theme",
                    isDark: isDark,
                    delay: 100,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ThemeAppearance()),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  _SettingsCard(
                    icon: LucideIcons.languages,
                    title: "Language",
                    subtitle: "Select your preferred language",
                    isDark: isDark,
                    delay: 200,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const LanguageScreen()),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // Section Divider
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 20,
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFFE29B4B)
                                : const Color(0xFFB87333),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'SECURITY & PRIVACY',
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            color: isDark
                                ? const Color(0xFFF5E6C8).withOpacity(0.8)
                                : const Color(0xFF3B2E1A).withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  _SettingsCard(
                    icon: LucideIcons.shieldCheck,
                    title: "Privacy & Security",
                    subtitle: "Control data and permissions",
                    isDark: isDark,
                    delay: 300,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const PrivacySecurityScreen()),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // Section Divider
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 20,
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFFE29B4B)
                                : const Color(0xFFB87333),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'SUPPORT',
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            color: isDark
                                ? const Color(0xFFF5E6C8).withOpacity(0.8)
                                : const Color(0xFF3B2E1A).withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  _SettingsCard(
                    icon: LucideIcons.helpCircle,
                    title: "Help & Support",
                    subtitle: "Get assistance and FAQs",
                    isDark: isDark,
                    delay: 400,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => HelpSupportScreen()),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  _SettingsCard(
                    icon: LucideIcons.info,
                    title: "About App",
                    subtitle: "Version, credits & features",
                    isDark: isDark,
                    delay: 500,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AboutAppScreen()),
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  // Footer Info Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [
                                const Color(0xFF2C1A12),
                                const Color(0xFF1F1B18),
                              ]
                            : [
                                const Color(0xFFF3E0C2),
                                const Color(0xFFE6DAC6),
                              ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: isDark
                            ? const Color(0xFF302518)
                            : const Color(0xFFA89B85),
                        width: 1.8,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? Colors.black.withOpacity(0.3)
                              : Colors.brown.withOpacity(0.1),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFFE29B4B).withOpacity(0.15)
                                : const Color(0xFFB87333).withOpacity(0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            LucideIcons.sparkles,
                            color: isDark
                                ? const Color(0xFFE29B4B)
                                : const Color(0xFFB87333),
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Cattle Pulse',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? const Color(0xFFF5E6C8)
                                : const Color(0xFF3B2E1A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Smart cattle management for modern farms',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isDark
                                ? const Color(0xFFF5E6C8).withOpacity(0.7)
                                : const Color(0xFF3B2E1A).withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1F1B18).withOpacity(0.5)
                                : const Color(0xFFE6DAC6).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Version 1.0.0 • © 2025',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isDark
                                  ? const Color(0xFFF5E6C8).withOpacity(0.6)
                                  : const Color(0xFF3B2E1A).withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isDark;
  final int delay;
  final VoidCallback onTap;

  const _SettingsCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isDark,
    required this.delay,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1F1B18) : const Color(0xFFE6DAC6),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isDark ? const Color(0xFF302518) : const Color(0xFFA89B85),
              width: 1.8,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.brown.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [
                            const Color(0xFF2C1A12),
                            const Color(0xFF241E1A),
                          ]
                        : [
                            const Color(0xFFF3E0C2),
                            const Color(0xFFEBD1A3),
                          ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withOpacity(0.2)
                          : Colors.brown.withOpacity(0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: isDark
                      ? const Color(0xFFE29B4B)
                      : const Color(0xFFB87333),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? const Color(0xFFF5E6C8)
                            : const Color(0xFF3B2E1A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? const Color(0xFFF5E6C8).withOpacity(0.7)
                            : const Color(0xFF3B2E1A).withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF2C1A12)
                      : const Color(0xFFF3E0C2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  LucideIcons.chevronRight,
                  size: 18,
                  color: isDark
                      ? const Color(0xFFE29B4B)
                      : const Color(0xFFB87333),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
