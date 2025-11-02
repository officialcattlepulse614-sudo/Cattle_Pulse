import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cattle_pulse/screens/menu_screens/settings_screen/notification_screen.dart';
import 'package:cattle_pulse/screens/menu_screens/settings_screen/about_app_screen.dart';
import 'package:cattle_pulse/screens/menu_screens/settings_screen/privacy_security_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Consumer<NotificationSettings>(
        builder: (context, ns, _) {
          if (!ns.initialized) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ── Notifications ──
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Notification Settings'),
                subtitle:
                    const Text('Manage all your notification preferences'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NotificationScreen(),
                    ),
                  );
                },
              ),
              const Divider(),

              // ── About App ──
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About App'),
                subtitle: const Text('Learn more about this application'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AboutAppScreen(),
                    ),
                  );
                },
              ),
              const Divider(),

              // ── Privacy & Security ──
              ListTile(
                leading: const Icon(Icons.lock_outline),
                title: const Text('Privacy & Security'),
                subtitle:
                    const Text('View privacy policy and security details'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PrivacySecurityScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),
            ],
          );
        },
      ),
    );
  }
}
