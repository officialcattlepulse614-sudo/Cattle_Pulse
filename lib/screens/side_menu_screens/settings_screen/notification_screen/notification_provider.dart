// lib/screens/menu_screens/settings_screen/notification_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSettings extends ChangeNotifier {
  static const String _kPushKey = 'notif_push_enabled';
  static const String _kPortalKey = 'notif_portal_enabled';
  static const String _kEmailKey = 'notif_email_enabled';
  static const String _kSmsKey = 'notif_sms_enabled';
  static const String _kSoundKey = 'notif_sound_enabled';
  static const String _kVibrateKey = 'notif_vibrate_enabled';

  bool pushEnabled = true;
  bool portalEnabled = true;
  bool emailEnabled = false;
  bool smsEnabled = false;
  bool soundEnabled = true;
  bool vibrateEnabled = true;
  bool initialized = false;

  NotificationSettings() {
    _loadFromPrefs();
  }

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

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kPushKey, pushEnabled);
    await prefs.setBool(_kPortalKey, portalEnabled);
    await prefs.setBool(_kEmailKey, emailEnabled);
    await prefs.setBool(_kSmsKey, smsEnabled);
    await prefs.setBool(_kSoundKey, soundEnabled);
    await prefs.setBool(_kVibrateKey, vibrateEnabled);
  }

  Future<void> setPushEnabled(bool value) async {
    pushEnabled = value;
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
