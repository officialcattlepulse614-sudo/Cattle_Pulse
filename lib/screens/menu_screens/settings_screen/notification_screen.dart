import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ─────────────────────────────────────────────────────────
///  MODEL + LOGIC SECTION (Provider)
/// ─────────────────────────────────────────────────────────
class NotificationSettings extends ChangeNotifier {
  // Keys for SharedPreferences
  static const String _kPushKey = 'notif_push_enabled';
  static const String _kPortalKey = 'notif_portal_enabled';
  static const String _kEmailKey = 'notif_email_enabled';
  static const String _kSmsKey = 'notif_sms_enabled';
  static const String _kSoundKey = 'notif_sound_enabled';
  static const String _kVibrateKey = 'notif_vibrate_enabled';

  // Local state with defaults
  bool pushEnabled = true;
  bool portalEnabled = true;
  bool emailEnabled = false;
  bool smsEnabled = false;
  bool soundEnabled = true;
  bool vibrateEnabled = true;

  // For convenience: indicates whether settings are loaded from storage
  bool initialized = false;

  NotificationSettings() {
    _loadFromPrefs();
  }

  // Load persisted settings (runs asynchronously)
  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    pushEnabled = prefs.getBool(_kPushKey) ?? pushEnabled;
    portalEnabled = prefs.getBool(_kPortalKey) ?? portalEnabled;
    emailEnabled = prefs.getBool(_kEmailKey) ?? emailEnabled;
    smsEnabled = prefs.getBool(_kSmsKey) ?? smsEnabled;
    soundEnabled = prefs.getBool(_kSoundKey) ?? soundEnabled;
    vibrateEnabled = prefs.getBool(_kVibrateKey) ?? vibrateEnabled;

    initialized = true;
    notifyListeners();
  }

  // Save full state (internal helper)
  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kPushKey, pushEnabled);
    await prefs.setBool(_kPortalKey, portalEnabled);
    await prefs.setBool(_kEmailKey, emailEnabled);
    await prefs.setBool(_kSmsKey, smsEnabled);
    await prefs.setBool(_kSoundKey, soundEnabled);
    await prefs.setBool(_kVibrateKey, vibrateEnabled);
  }

  // Toggle helpers (each toggles & persists)
  Future<void> setPushEnabled(bool value) async {
    pushEnabled = value;
    // optional: when disabling push, also disable sound/vibrate
    if (!value) {
      soundEnabled = false;
      vibrateEnabled = false;
    }
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> setPortalEnabled(bool value) async {
    portalEnabled = value;
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> setEmailEnabled(bool value) async {
    emailEnabled = value;
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> setSmsEnabled(bool value) async {
    smsEnabled = value;
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> setSoundEnabled(bool value) async {
    soundEnabled = value;
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> setVibrateEnabled(bool value) async {
    vibrateEnabled = value;
    await _saveToPrefs();
    notifyListeners();
  }

  // A quick reset method
  Future<void> restoreDefaults() async {
    pushEnabled = true;
    portalEnabled = true;
    emailEnabled = false;
    smsEnabled = false;
    soundEnabled = true;
    vibrateEnabled = true;
    await _saveToPrefs();
    notifyListeners();
  }
}

/// ─────────────────────────────────────────────────────────
///  UI SECTION (Screen)
/// ─────────────────────────────────────────────────────────
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        centerTitle: true,
      ),
      body: Consumer<NotificationSettings>(
        builder: (context, ns, _) {
          if (!ns.initialized) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ── Push Notifications ──
              Text(
                'Push Notifications',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              SwitchListTile.adaptive(
                value: ns.pushEnabled,
                onChanged: (v) => ns.setPushEnabled(v),
                title: const Text('Enable Push Notifications'),
                subtitle:
                    const Text('Turn notifications on or off for this device'),
                secondary: const Icon(Icons.notifications_active),
              ),
              const Divider(),

              // ── Delivery Channels ──
              Text(
                'Delivery Channels',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              SwitchListTile.adaptive(
                value: ns.portalEnabled,
                onChanged: (v) => ns.setPortalEnabled(v),
                title: const Text('Portal Notifications'),
                subtitle: const Text('Receive portal/web updates and alerts.'),
                secondary: const Icon(Icons.web),
              ),
              SwitchListTile.adaptive(
                value: ns.emailEnabled,
                onChanged: (v) => ns.setEmailEnabled(v),
                title: const Text('Email Notifications'),
                subtitle: const Text('Send alerts to your email inbox.'),
                secondary: const Icon(Icons.email_outlined),
              ),
              SwitchListTile.adaptive(
                value: ns.smsEnabled,
                onChanged: (v) => ns.setSmsEnabled(v),
                title: const Text('SMS Notifications'),
                subtitle: const Text('Receive important alerts via SMS.'),
                secondary: const Icon(Icons.sms_outlined),
              ),
              const Divider(),

              // ── Behavior & Sounds ──
              Text(
                'Behavior & Sounds',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              SwitchListTile.adaptive(
                value: ns.soundEnabled,
                onChanged: ns.pushEnabled ? (v) => ns.setSoundEnabled(v) : null,
                title: const Text('Sound'),
                subtitle: const Text('Play a sound for notifications'),
                secondary: const Icon(Icons.volume_up),
              ),
              SwitchListTile.adaptive(
                value: ns.vibrateEnabled,
                onChanged:
                    ns.pushEnabled ? (v) => ns.setVibrateEnabled(v) : null,
                title: const Text('Vibrate'),
                subtitle: const Text('Vibrate when a notification arrives'),
                secondary: const Icon(Icons.vibration),
              ),
              const Divider(),

              // ── Restore Defaults ──
              ElevatedButton.icon(
                onPressed: () async {
                  await ns.restoreDefaults();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Restored default notification settings'),
                    ),
                  );
                },
                icon: const Icon(Icons.restore),
                label: const Text('Restore Defaults'),
              ),
            ],
          );
        },
      ),
    );
  }
}
