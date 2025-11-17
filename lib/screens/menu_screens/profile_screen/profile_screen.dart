// profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cattle_pulse/controllers/menu_app_controller.dart';
import 'package:cattle_pulse/screens/auth/login_screen.dart';
import 'package:cattle_pulse/screens/menu_screens/profile_screen/edit_profile.dart';
import 'package:cattle_pulse/screens/menu_screens/settings_screen/privacy_security_screen.dart';
import 'package:cattle_pulse/screens/menu_screens/settings_screen/about_app_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final controller = Provider.of<MenuAppController>(context);
    final imageProvider = controller.profileImageProvider;
    final String userName = controller.userName;

    final Color appBarColor =
        isDark ? const Color(0xFF1F1B18) : const Color(0xFFEADAC0);
    final Color scaffoldBg =
        isDark ? const Color(0xFF121212) : const Color(0xFFFDF6E3);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: isDark
                  ? const LinearGradient(
                      colors: [Color(0xFF121212), Color(0xFF1E1E1E)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                  : const LinearGradient(
                      colors: [Color(0xFFFDF6E3), Color(0xFFF8E6C2)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
            ),
          ),

          // Floating custom top bar
          Positioned(
            top: 6,
            left: 6,
            right: 6,
            child: Material(
              elevation: 8,
              shadowColor: Colors.black26,
              borderRadius: BorderRadius.circular(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(color: appBarColor),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: isDark
                              ? const Color(0xFFE29B4B)
                              : const Color(0xFFB87333),
                        ),
                        onPressed: () {
                          controller.selectMenu("Dashboard");
                        },
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Profile",
                        style: TextStyle(
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
          Padding(
            padding: const EdgeInsets.only(top: 140),
            child: Center(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundImage: imageProvider,
                        backgroundColor:
                            isDark ? Colors.grey[800] : Colors.grey[200],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "admin@cattlepulse.com",
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.white70 : Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.edit, size: 18),
                        label: const Text("Edit Profile"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark
                              ? const Color(0xFFE29B4B)
                              : const Color(0xFFB87333),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfileScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 40),

                      // ---------- Options ----------
                      _buildProfileOption(
                        icon: Icons.settings,
                        text: "Settings",
                        isDark: isDark,
                        onTap: () => controller.selectMenu("Settings"),
                      ),
                      _buildProfileOption(
                        icon: Icons.lock,
                        text: "Privacy & Security",
                        isDark: isDark,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PrivacySecurityScreen(),
                            ),
                          );
                        },
                      ),
                      _buildProfileOption(
                        icon: Icons.info_outline,
                        text: "About App",
                        isDark: isDark,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AboutAppScreen(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 50),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.logout),
                        label: const Text("Logout"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
        color:
            isDark ? const Color(0xFF1E1E1E) : Colors.white.withOpacity(0.95),
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
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: isDark ? Colors.white54 : Colors.grey[600],
        ),
        onTap: onTap,
      ),
    );
  }
}
