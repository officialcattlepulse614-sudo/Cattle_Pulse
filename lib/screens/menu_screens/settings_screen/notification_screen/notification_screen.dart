// lib/screens/menu_screens/settings_screen/notification_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notification_provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
            // Floating AppBar (same style as AboutAppScreen)
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
                        : const Color.fromARGB(255, 230, 218, 198),
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
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      const SizedBox(height: 10),
                      _buildSectionTitle("Push Notifications", theme),
                      _buildCardTile(
                        context,
                        theme,
                        child: SwitchListTile.adaptive(
                          activeColor: activeColor,
                          value: ns.pushEnabled,
                          onChanged: (v) => ns.setPushEnabled(v),
                          title: const Text("Enable Push Notifications"),
                          subtitle: const Text(
                              "Turn notifications on or off for this device"),
                          secondary: Icon(
                            Icons.notifications_active_rounded,
                            color: activeColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildSectionTitle("Delivery Channels", theme),
                      _buildCardTile(
                        context,
                        theme,
                        child: SwitchListTile.adaptive(
                          activeColor: activeColor,
                          value: ns.portalEnabled,
                          onChanged: (v) => ns.setPortalEnabled(v),
                          title: const Text("Portal Notifications"),
                          subtitle: const Text(
                              "Receive portal/web updates and alerts."),
                          secondary: Icon(
                            Icons.dashboard_customize_rounded,
                            color: activeColor,
                          ),
                        ),
                      ),
                      _buildCardTile(
                        context,
                        theme,
                        child: SwitchListTile.adaptive(
                          activeColor: activeColor,
                          value: ns.emailEnabled,
                          onChanged: (v) => ns.setEmailEnabled(v),
                          title: const Text("Email Notifications"),
                          subtitle:
                              const Text("Send alerts to your email inbox."),
                          secondary: Icon(
                            Icons.email_rounded,
                            color: activeColor,
                          ),
                        ),
                      ),
                      _buildCardTile(
                        context,
                        theme,
                        child: SwitchListTile.adaptive(
                          activeColor: activeColor,
                          value: ns.smsEnabled,
                          onChanged: (v) => ns.setSmsEnabled(v),
                          title: const Text("SMS Notifications"),
                          subtitle:
                              const Text("Receive important alerts via SMS."),
                          secondary: Icon(
                            Icons.sms_rounded,
                            color: activeColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildSectionTitle("Behavior & Sounds", theme),
                      _buildCardTile(
                        context,
                        theme,
                        child: SwitchListTile.adaptive(
                          activeColor: activeColor,
                          value: ns.soundEnabled,
                          onChanged: ns.pushEnabled
                              ? (v) => ns.setSoundEnabled(v)
                              : null,
                          title: const Text("Sound"),
                          subtitle: const Text(
                              "Play a sound when notifications arrive"),
                          secondary: Icon(
                            Icons.volume_up_rounded,
                            color: ns.pushEnabled ? activeColor : Colors.grey,
                          ),
                        ),
                      ),
                      _buildCardTile(
                        context,
                        theme,
                        child: SwitchListTile.adaptive(
                          activeColor: activeColor,
                          value: ns.vibrateEnabled,
                          onChanged: ns.pushEnabled
                              ? (v) => ns.setVibrateEnabled(v)
                              : null,
                          title: const Text("Vibration"),
                          subtitle:
                              const Text("Vibrate when a notification arrives"),
                          secondary: Icon(
                            Icons.vibration_rounded,
                            color: ns.pushEnabled ? activeColor : Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: activeColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () async {
                            await ns.restoreDefaults();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Restored default notification settings"),
                              ),
                            );
                          },
                          icon: const Icon(Icons.restore_rounded),
                          label: const Text("Restore Defaults"),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildCardTile(BuildContext context, ThemeData theme,
      {required Widget child}) {
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isDark
              ? const Color(0xFF1E1E1E)
              : const Color.fromARGB(255, 248, 234, 220),
        ),
        child: child,
      ),
    );
  }
}
