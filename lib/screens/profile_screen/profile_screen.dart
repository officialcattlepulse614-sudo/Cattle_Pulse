import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cattle_pulse/screens/auth/login_screen.dart';
import 'package:cattle_pulse/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:cattle_pulse/screens/privacy_screen/privacy_screen.dart';
import 'package:cattle_pulse/screens/about_screen/about_screen.dart';
import 'package:cattle_pulse/screens/settings_screen/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF9F9F9),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // 👤 Profile Avatar
                CircleAvatar(
                  radius: 55,
                  backgroundColor: isDark ? Colors.grey[800] : Colors.grey[300],
                  child: Icon(Icons.person, size: 65, color: isDark ? Colors.white70 : Colors.black54),
                ),
                const SizedBox(height: 20),

                // 🧍‍♂️ User Info
                Text(
                  tr('admin_user'),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  tr('admin_email'),
                  style: TextStyle(fontSize: 14, color: isDark ? Colors.white70 : Colors.grey[700]),
                ),
                const SizedBox(height: 25),

                // ✏️ Edit Profile
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit, size: 18),
                  label: Text(tr('edit_profile')),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? const Color(0xFFE29B4B) : const Color(0xFFB87333),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen()));
                  },
                ),
                const SizedBox(height: 40),

                // ⚙️ Options
                _buildProfileOption(
                  icon: Icons.settings,
                  text: tr('settings'),
                  isDark: isDark,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
                ),
                _buildProfileOption(
                  icon: Icons.lock,
                  text: tr('privacy_security'),
                  isDark: isDark,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyScreen())),
                ),
                _buildProfileOption(
                  icon: Icons.info_outline,
                  text: tr('about_app'),
                  isDark: isDark,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen())),
                ),

                const SizedBox(height: 50),

                // 🚪 Logout Button
                ElevatedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: Text(tr('logout')),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String text,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black54 : Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: isDark ? Colors.white70 : Colors.black87),
        title: Text(
          text,
          style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: isDark ? Colors.white54 : Colors.grey[600]),
        onTap: onTap,
      ),
    );
  }
}

