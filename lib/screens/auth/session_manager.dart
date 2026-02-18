// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SessionManager {
//   static final SessionManager _instance = SessionManager._internal();
//   factory SessionManager() => _instance;
//   SessionManager._internal();

//   Timer? _inactivityTimer;
//   final Duration _sessionTimeout =
//       const Duration(minutes: 15); // 15 minutes timeout
//   static const String _lastActivityKey = 'last_activity_time';

//   // Initialize session manager
//   Future<void> initialize() async {
//     await _checkSessionOnStartup();
//     _startInactivityTimer();
//     _recordActivity();
//   }

//   // Check if session expired when app starts/reopens
//   Future<void> _checkSessionOnStartup() async {
//     final prefs = await SharedPreferences.getInstance();
//     final lastActivityString = prefs.getString(_lastActivityKey);

//     if (lastActivityString == null) {
//       // First time opening app
//       return;
//     }

//     final lastActivity = DateTime.parse(lastActivityString);
//     final now = DateTime.now();
//     final difference = now.difference(lastActivity);

//     // If more than 15 minutes have passed, logout
//     if (difference >= _sessionTimeout) {
//       await _logout();
//     }
//   }

//   // Start inactivity timer (runs while app is active)
//   void _startInactivityTimer() {
//     _inactivityTimer?.cancel();

//     // Check every minute while app is running
//     _inactivityTimer =
//         Timer.periodic(const Duration(minutes: 1), (timer) async {
//       await _checkInactivity();
//     });
//   }

//   // Check if session has expired
//   Future<void> _checkInactivity() async {
//     final prefs = await SharedPreferences.getInstance();
//     final lastActivityString = prefs.getString(_lastActivityKey);

//     if (lastActivityString == null) return;

//     final lastActivity = DateTime.parse(lastActivityString);
//     final now = DateTime.now();
//     final difference = now.difference(lastActivity);

//     if (difference >= _sessionTimeout) {
//       // Session expired - sign out
//       await _logout();
//     }
//   }

//   // Record user activity
//   Future<void> _recordActivity() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_lastActivityKey, DateTime.now().toIso8601String());
//   }

//   // Call this when user performs any action (tap, scroll, etc.)
//   void recordActivity() {
//     _recordActivity();
//   }

//   // Logout user and clear session data
//   Future<void> _logout() async {
//     _inactivityTimer?.cancel();
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_lastActivityKey);
//     await FirebaseAuth.instance.signOut();
//   }

//   // Cleanup
//   void dispose() {
//     _inactivityTimer?.cancel();
//   }
// }

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;
  SessionManager._internal();

  Timer? _inactivityTimer;
  final Duration _sessionTimeout = const Duration(minutes: 15);
  static const String _lastActivityKey = 'last_activity_time';
  static const String _isAppRunningKey = 'is_app_running';

  // Initialize session manager
  Future<void> initialize() async {
    await _checkSessionOnStartup();
    _startInactivityTimer();
    await _markAppAsRunning(true);
    _recordActivity();
  }

  // Mark app as running/closed
  Future<void> _markAppAsRunning(bool isRunning) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isAppRunningKey, isRunning);
  }

  // Check if app was properly closed
  Future<bool> _wasAppProperlyClosed() async {
    final prefs = await SharedPreferences.getInstance();
    final wasRunning = prefs.getBool(_isAppRunningKey) ?? false;
    return !wasRunning; // If app wasn't marked as running, it was closed
  }

  // Check if session expired when app starts/reopens
  Future<void> _checkSessionOnStartup() async {
    final prefs = await SharedPreferences.getInstance();
    final lastActivityString = prefs.getString(_lastActivityKey);
    final wasProperlyClosedBefore = await _wasAppProperlyClosed();

    // For mobile: if app was closed (not running), clear session
    if (!kIsWeb && wasProperlyClosedBefore) {
      await _logout();
      return;
    }

    // For web: Always clear session on browser reopen
    // (Web apps don't maintain state across browser restarts)
    if (kIsWeb) {
      // Check if this is a fresh browser session
      final sessionStartTime = prefs.getString('session_start_time');
      if (sessionStartTime == null) {
        // New session - logout any existing Firebase auth
        if (FirebaseAuth.instance.currentUser != null) {
          await _logout();
        }
      }
    }

    if (lastActivityString == null) {
      return;
    }

    final lastActivity = DateTime.parse(lastActivityString);
    final now = DateTime.now();
    final difference = now.difference(lastActivity);

    // If more than 15 minutes have passed, logout
    if (difference >= _sessionTimeout) {
      await _logout();
    }
  }

  // Start inactivity timer (runs while app is active)
  void _startInactivityTimer() {
    _inactivityTimer?.cancel();

    // Check every minute while app is running
    _inactivityTimer =
        Timer.periodic(const Duration(minutes: 1), (timer) async {
      await _checkInactivity();
    });
  }

  // Check if session has expired
  Future<void> _checkInactivity() async {
    final prefs = await SharedPreferences.getInstance();
    final lastActivityString = prefs.getString(_lastActivityKey);

    if (lastActivityString == null) return;

    final lastActivity = DateTime.parse(lastActivityString);
    final now = DateTime.now();
    final difference = now.difference(lastActivity);

    if (difference >= _sessionTimeout) {
      await _logout();
    }
  }

  // Record user activity
  Future<void> _recordActivity() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastActivityKey, DateTime.now().toIso8601String());
  }

  // Call this when user performs any action
  void recordActivity() {
    _recordActivity();
  }

  // Call this when user logs in successfully
  Future<void> onLoginSuccess() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'session_start_time', DateTime.now().toIso8601String());
    await _markAppAsRunning(true);
    await _recordActivity();
  }

  // Logout user and clear session data
  Future<void> _logout() async {
    _inactivityTimer?.cancel();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_lastActivityKey);
    await prefs.remove('session_start_time');
    await prefs.setBool(_isAppRunningKey, false);

    // Sign out from Firebase
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }

  // Call this when app is paused/closed
  Future<void> onAppPaused() async {
    await _markAppAsRunning(false);
    await _recordActivity();
  }

  // Call this when app is resumed
  Future<void> onAppResumed() async {
    await _markAppAsRunning(true);
    await _checkSessionOnStartup();
  }

  // Manual logout
  Future<void> logout() async {
    await _logout();
  }

  // Cleanup
  void dispose() {
    _inactivityTimer?.cancel();
  }
}
