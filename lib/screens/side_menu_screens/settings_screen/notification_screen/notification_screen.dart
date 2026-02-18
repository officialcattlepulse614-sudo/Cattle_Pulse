// lib/screens/menu_screens/settings_screen/notification_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'notification_provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
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
    final isDark = theme.brightness == Brightness.dark;
    final Color activeColor =
        isDark ? const Color(0xFFE29B4B) : const Color(0xFFB87333);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            // Floating AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              child: Material(
                elevation: 8,
                shadowColor: Colors.black26,
                borderRadius: BorderRadius.circular(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 50,
                    color: isDark
                        ? const Color(0xFF1F1B18)
                        : const Color(0xFFE6DAC6),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: activeColor,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Notification Settings',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            letterSpacing: 0.8,
                            color: isDark
                                ? const Color(0xFFF5E6C8)
                                : const Color(0xFF3B2E1A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Main content
            Expanded(
              child: Consumer<NotificationSettings>(
                builder: (context, ns, _) {
                  if (!ns.initialized) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: activeColor,
                      ),
                    );
                  }

                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: ListView(
                        padding: const EdgeInsets.all(6),
                        children: [
                          const SizedBox(height: 4),

                          // Header Section
                          Row(
                            children: [
                              const SizedBox(width: 9),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF1F1B18) //Dark Mode
                                      : const Color(0xFFE6DAC6), //Light Modes,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isDark
                                        ? const Color(0xFF302518) // Dark Mode
                                        : const Color(0xFFA89B85), // Light Mode
                                    width: 1.8,
                                  ),
                                ),
                                child: Icon(
                                  Icons.campaign_rounded,
                                  size: 28,
                                  color: isDark
                                      ? const Color(0xFFE29B4B) //Dark Mode
                                      : const Color(0xFFB87333), //Light Mode
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 1),
                                    Text(
                                      'Manage alerts and updates',
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

                          const SizedBox(height: 28),

                          // Push Notifications Section
                          _buildSectionHeader(
                            context: context,
                            title: "PUSH NOTIFICATIONS",
                            isDark: isDark,
                          ),

                          const SizedBox(height: 12),

                          _NotificationCard(
                            isDark: isDark,
                            delay: 0,
                            child: SwitchListTile.adaptive(
                              activeColor: activeColor,
                              value: ns.pushEnabled,
                              onChanged: (v) => ns.setPushEnabled(v),
                              title: Text(
                                "Enable Push Notifications",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? const Color(0xFFF5E6C8)
                                      : const Color(0xFF3B2E1A),
                                ),
                              ),
                              subtitle: Text(
                                "Turn notifications on or off for this device",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: isDark
                                      ? const Color(0xFFF5E6C8).withOpacity(0.7)
                                      : const Color(0xFF3B2E1A)
                                          .withOpacity(0.7),
                                ),
                              ),
                              secondary: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: activeColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  LucideIcons.bellRing,
                                  color: activeColor,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 28),

                          // Delivery Channels Section
                          _buildSectionHeader(
                            context: context,
                            title: "DELIVERY CHANNELS",
                            isDark: isDark,
                          ),

                          const SizedBox(height: 12),

                          _NotificationCard(
                            isDark: isDark,
                            delay: 100,
                            child: SwitchListTile.adaptive(
                              activeColor: activeColor,
                              value: ns.portalEnabled,
                              onChanged: (v) => ns.setPortalEnabled(v),
                              title: Text(
                                "Portal Notifications",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? const Color(0xFFF5E6C8)
                                      : const Color(0xFF3B2E1A),
                                ),
                              ),
                              subtitle: Text(
                                "Receive portal/web updates and alerts",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: isDark
                                      ? const Color(0xFFF5E6C8).withOpacity(0.7)
                                      : const Color(0xFF3B2E1A)
                                          .withOpacity(0.7),
                                ),
                              ),
                              secondary: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: activeColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  LucideIcons.monitor,
                                  color: activeColor,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          _NotificationCard(
                            isDark: isDark,
                            delay: 150,
                            child: SwitchListTile.adaptive(
                              activeColor: activeColor,
                              value: ns.emailEnabled,
                              onChanged: (v) => ns.setEmailEnabled(v),
                              title: Text(
                                "Email Notifications",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? const Color(0xFFF5E6C8)
                                      : const Color(0xFF3B2E1A),
                                ),
                              ),
                              subtitle: Text(
                                "Send alerts to your email inbox",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: isDark
                                      ? const Color(0xFFF5E6C8).withOpacity(0.7)
                                      : const Color(0xFF3B2E1A)
                                          .withOpacity(0.7),
                                ),
                              ),
                              secondary: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: activeColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  LucideIcons.mail,
                                  color: activeColor,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          _NotificationCard(
                            isDark: isDark,
                            delay: 200,
                            child: SwitchListTile.adaptive(
                              activeColor: activeColor,
                              value: ns.smsEnabled,
                              onChanged: (v) => ns.setSmsEnabled(v),
                              title: Text(
                                "SMS Notifications",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? const Color(0xFFF5E6C8)
                                      : const Color(0xFF3B2E1A),
                                ),
                              ),
                              subtitle: Text(
                                "Receive important alerts via SMS",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: isDark
                                      ? const Color(0xFFF5E6C8).withOpacity(0.7)
                                      : const Color(0xFF3B2E1A)
                                          .withOpacity(0.7),
                                ),
                              ),
                              secondary: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: activeColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  LucideIcons.messageSquare,
                                  color: activeColor,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 28),

                          // Behavior & Sounds Section
                          _buildSectionHeader(
                            context: context,
                            title: "BEHAVIOR & SOUNDS",
                            isDark: isDark,
                          ),

                          const SizedBox(height: 12),

                          _NotificationCard(
                            isDark: isDark,
                            delay: 250,
                            child: SwitchListTile.adaptive(
                              activeColor: activeColor,
                              value: ns.soundEnabled,
                              onChanged: ns.pushEnabled
                                  ? (v) => ns.setSoundEnabled(v)
                                  : null,
                              title: Text(
                                "Sound",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? (ns.pushEnabled
                                          ? const Color(0xFFF5E6C8)
                                          : const Color(0xFFF5E6C8)
                                              .withOpacity(0.5))
                                      : (ns.pushEnabled
                                          ? const Color(0xFF3B2E1A)
                                          : const Color(0xFF3B2E1A)
                                              .withOpacity(0.5)),
                                ),
                              ),
                              subtitle: Text(
                                "Play a sound when notifications arrive",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: isDark
                                      ? const Color(0xFFF5E6C8).withOpacity(0.7)
                                      : const Color(0xFF3B2E1A)
                                          .withOpacity(0.7),
                                ),
                              ),
                              secondary: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: ns.pushEnabled
                                      ? activeColor.withOpacity(0.15)
                                      : Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  LucideIcons.volume2,
                                  color: ns.pushEnabled
                                      ? activeColor
                                      : Colors.grey,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          _NotificationCard(
                            isDark: isDark,
                            delay: 300,
                            child: SwitchListTile.adaptive(
                              activeColor: activeColor,
                              value: ns.vibrateEnabled,
                              onChanged: ns.pushEnabled
                                  ? (v) => ns.setVibrateEnabled(v)
                                  : null,
                              title: Text(
                                "Vibration",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? (ns.pushEnabled
                                          ? const Color(0xFFF5E6C8)
                                          : const Color(0xFFF5E6C8)
                                              .withOpacity(0.5))
                                      : (ns.pushEnabled
                                          ? const Color(0xFF3B2E1A)
                                          : const Color(0xFF3B2E1A)
                                              .withOpacity(0.5)),
                                ),
                              ),
                              subtitle: Text(
                                "Vibrate when a notification arrives",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: isDark
                                      ? const Color(0xFFF5E6C8).withOpacity(0.7)
                                      : const Color(0xFF3B2E1A)
                                          .withOpacity(0.7),
                                ),
                              ),
                              secondary: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: ns.pushEnabled
                                      ? activeColor.withOpacity(0.15)
                                      : Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  LucideIcons.smartphone,
                                  color: ns.pushEnabled
                                      ? activeColor
                                      : Colors.grey,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Restore Defaults Button
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: activeColor.withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: activeColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () async {
                                  await ns.restoreDefaults();
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Row(
                                          children: [
                                            Icon(
                                              LucideIcons.checkCircle,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 12),
                                            const Text(
                                              "Restored default settings",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        backgroundColor: activeColor,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                icon: const Icon(
                                  LucideIcons.rotateCcw,
                                  size: 20,
                                ),
                                label: const Text(
                                  "Restore Defaults",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Info Footer
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF1F1B18).withOpacity(0.5)
                                  : const Color(0xFFE6DAC6).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isDark
                                    ? const Color(0xFF302518)
                                    : const Color(0xFFA89B85),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  LucideIcons.info,
                                  size: 20,
                                  color: activeColor,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Your notification preferences are automatically saved',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: isDark
                                          ? const Color(0xFFF5E6C8)
                                              .withOpacity(0.8)
                                          : const Color(0xFF3B2E1A)
                                              .withOpacity(0.8),
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required BuildContext context,
    required String title,
    required bool isDark,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFFE29B4B) : const Color(0xFFB87333),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
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
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final Widget child;
  final bool isDark;
  final int delay;

  const _NotificationCard({
    required this.child,
    required this.isDark,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
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
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1F1B18) : const Color(0xFFE6DAC6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? const Color(0xFF302518) : const Color(0xFFA89B85),
            width: 1.5,
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
        child: child,
      ),
    );
  }
}
