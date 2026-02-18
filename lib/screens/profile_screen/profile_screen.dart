// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:cattle_pulse/controllers/menu_app_controller.dart';
// import 'package:cattle_pulse/screens/auth/login_screen.dart';
// import 'package:cattle_pulse/screens/profile_screen/edit_profile.dart';
// import 'package:cattle_pulse/screens/side_menu_screens/settings_screen/privacy_security_screen.dart';
// import 'package:cattle_pulse/screens/side_menu_screens/settings_screen/about_app_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:lucide_icons/lucide_icons.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final bool isDark = theme.brightness == Brightness.dark;
//     final controller = Provider.of<MenuAppController>(context);
//     final imageProvider = controller.profileImageProvider;
//     final String userName = controller.userName;

//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Main Content
//             Padding(
//               padding: const EdgeInsets.only(top: 80),
//               child: SingleChildScrollView(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                 child: Center(
//                   child: ConstrainedBox(
//                     constraints: const BoxConstraints(maxWidth: 600),
//                     child: Column(
//                       children: [
//                         // Profile Card
//                         Container(
//                           padding: const EdgeInsets.all(32),
//                           decoration: BoxDecoration(
//                             color: isDark
//                                 ? const Color(0xFF1F1B18)
//                                 : const Color(0xFFE6DAC6),
//                             borderRadius: BorderRadius.circular(24),
//                           ),
//                           child: Column(
//                             children: [
//                               // Avatar with decorative ring
//                               Stack(
//                                 alignment: Alignment.center,
//                                 children: [
//                                   Container(
//                                     width: 120,
//                                     height: 120,
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       gradient: RadialGradient(
//                                         colors: isDark
//                                             ? [
//                                                 const Color(0xFFE29B4B)
//                                                     .withOpacity(0.3),
//                                                 Colors.transparent,
//                                               ]
//                                             : [
//                                                 const Color(0xFFB87333)
//                                                     .withOpacity(0.3),
//                                                 Colors.transparent,
//                                               ],
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       border: Border.all(
//                                         color: isDark
//                                             ? const Color(0xFFE29B4B)
//                                             : const Color(0xFFB87333),
//                                         width: 3,
//                                       ),
//                                     ),
//                                     child: CircleAvatar(
//                                       radius: 80,
//                                       backgroundImage: imageProvider,
//                                       backgroundColor: isDark
//                                           ? const Color(0xFF2C1A12)
//                                           : const Color(0xFFF3E0C2),
//                                     ),
//                                   ),
//                                 ],
//                               ),

//                               const SizedBox(height: 20),

//                               Text(
//                                 userName,
//                                 style: TextStyle(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.w800,
//                                   color: isDark
//                                       ? const Color(0xFFF5E6C8)
//                                       : const Color(0xFF3B2E1A),
//                                 ),
//                               ),
//                               const SizedBox(height: 8),

//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     LucideIcons.mail,
//                                     size: 16,
//                                     color: isDark
//                                         ? const Color(0xFFE29B4B)
//                                         : const Color(0xFFB87333),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     FirebaseAuth.instance.currentUser?.email ??
//                                         "No Email",
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                       color: isDark
//                                           ? const Color(0xFFF5E6C8)
//                                               .withOpacity(0.8)
//                                           : const Color(0xFF3B2E1A)
//                                               .withOpacity(0.8),
//                                     ),
//                                   ),
//                                 ],
//                               ),

//                               const SizedBox(height: 24),

//                               // Edit Profile Button
//                               InkWell(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           const EditProfileScreen(),
//                                     ),
//                                   );
//                                 },
//                                 borderRadius: BorderRadius.circular(16),
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 28, vertical: 12),
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: isDark
//                                           ? [
//                                               const Color(0xFFE29B4B),
//                                               const Color(0xFFD88A3A),
//                                             ]
//                                           : [
//                                               const Color(0xFFB87333),
//                                               const Color(0xFFA66324),
//                                             ],
//                                     ),
//                                     borderRadius: BorderRadius.circular(16),
//                                   ),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Icon(
//                                         LucideIcons.edit,
//                                         size: 18,
//                                         color: isDark
//                                             ? const Color(0xFF1F1B18)
//                                             : Colors.white,
//                                       ),
//                                       const SizedBox(width: 10),
//                                       Text(
//                                         "Edit Profile",
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.w700,
//                                           color: isDark
//                                               ? const Color(0xFF1F1B18)
//                                               : Colors.white,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         const SizedBox(height: 24),

//                         // Options Grid
//                         Row(
//                           children: [
//                             Expanded(
//                               child: _smallOptionCard(
//                                 icon: LucideIcons.settings,
//                                 text: "Settings",
//                                 isDark: isDark,
//                                 onTap: () => controller.selectMenu("Settings"),
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: _smallOptionCard(
//                                 icon: LucideIcons.shield,
//                                 text: "Privacy",
//                                 isDark: isDark,
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           const PrivacySecurityScreen(),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),

//                         const SizedBox(height: 16),

//                         Row(
//                           children: [
//                             Expanded(
//                               child: _smallOptionCard(
//                                 icon: LucideIcons.info,
//                                 text: "About App",
//                                 isDark: isDark,
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           const AboutAppScreen(),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: _smallOptionCard(
//                                 icon: LucideIcons.logOut,
//                                 text: "Logout",
//                                 isDark: isDark,
//                                 isLogout: true,
//                                 onTap: () {
//                                   Navigator.pushAndRemoveUntil(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             const LoginScreen()),
//                                     (route) => false,
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),

//                         const SizedBox(height: 30),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             // Floating AppBar
//             Positioned(
//               top: 5,
//               left: 6,
//               right: 6,
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
//                 decoration: BoxDecoration(
//                   color: isDark
//                       ? const Color(0xFF1F1B18)
//                       : const Color(0xFFE6DAC6),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   children: [
//                     InkWell(
//                       onTap: () => controller.selectMenu("Dashboard"),
//                       borderRadius: BorderRadius.circular(20),
//                       child: Container(
//                         padding: const EdgeInsets.all(8),
//                         child: Icon(
//                           Icons.arrow_back_ios_new_rounded,
//                           color: isDark
//                               ? const Color(0xFFE29B4B)
//                               : const Color(0xFFB87333),
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Text(
//                       "Profile",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                         color: isDark
//                             ? const Color(0xFFF5E6C8)
//                             : const Color(0xFF3B2E1A),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _smallOptionCard({
//     required IconData icon,
//     required String text,
//     required bool isDark,
//     required VoidCallback onTap,
//     bool isLogout = false,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(20),
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//         decoration: BoxDecoration(
//           color: isLogout
//               ? (isDark
//                   ? const Color(0xFF8B2020).withOpacity(0.8)
//                   : const Color(0xFFE53935).withOpacity(0.9))
//               : (isDark ? const Color(0xFF1F1B18) : const Color(0xFFE6DAC6)),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: isLogout
//                     ? Colors.white.withOpacity(0.15)
//                     : (isDark
//                         ? const Color(0xFF2C1A12).withOpacity(0.5)
//                         : const Color(0xFFF3E0C2).withOpacity(0.5)),
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: Icon(
//                 icon,
//                 color: isLogout
//                     ? Colors.white
//                     : (isDark
//                         ? const Color(0xFFE29B4B)
//                         : const Color(0xFFB87333)),
//                 size: 24,
//               ),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               text,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w700,
//                 color: isLogout
//                     ? Colors.white
//                     : (isDark
//                         ? const Color(0xFFF5E6C8)
//                         : const Color(0xFF3B2E1A)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cattle_pulse/controllers/menu_app_controller.dart';
import 'package:cattle_pulse/screens/profile_screen/edit_profile.dart';
import 'package:cattle_pulse/screens/side_menu_screens/settings_screen/privacy_security_screen.dart';
import 'package:cattle_pulse/screens/side_menu_screens/settings_screen/about_app_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final controller = Provider.of<MenuAppController>(context);
    final imageProvider = controller.profileImageProvider;
    final String userName = controller.userName;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(
                      children: [
                        // Profile Card
                        Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1F1B18)
                                : const Color(0xFFE6DAC6),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            children: [
                              // Avatar with decorative ring
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(
                                        colors: isDark
                                            ? [
                                                const Color(0xFFE29B4B)
                                                    .withOpacity(0.3),
                                                Colors.transparent,
                                              ]
                                            : [
                                                const Color(0xFFB87333)
                                                    .withOpacity(0.3),
                                                Colors.transparent,
                                              ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isDark
                                            ? const Color(0xFFE29B4B)
                                            : const Color(0xFFB87333),
                                        width: 3,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 80,
                                      backgroundImage: imageProvider,
                                      backgroundColor: isDark
                                          ? const Color(0xFF2C1A12)
                                          : const Color(0xFFF3E0C2),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              Text(
                                userName,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: isDark
                                      ? const Color(0xFFF5E6C8)
                                      : const Color(0xFF3B2E1A),
                                ),
                              ),
                              const SizedBox(height: 8),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    LucideIcons.mail,
                                    size: 16,
                                    color: isDark
                                        ? const Color(0xFFE29B4B)
                                        : const Color(0xFFB87333),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    FirebaseAuth.instance.currentUser?.email ??
                                        "No Email",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: isDark
                                          ? const Color(0xFFF5E6C8)
                                              .withOpacity(0.8)
                                          : const Color(0xFF3B2E1A)
                                              .withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),

                              // Edit Profile Button
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const EditProfileScreen(),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 28, vertical: 12),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: isDark
                                          ? [
                                              const Color(0xFFE29B4B),
                                              const Color(0xFFD88A3A),
                                            ]
                                          : [
                                              const Color(0xFFB87333),
                                              const Color(0xFFA66324),
                                            ],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        LucideIcons.edit,
                                        size: 18,
                                        color: isDark
                                            ? const Color(0xFF1F1B18)
                                            : Colors.white,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Edit Profile",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: isDark
                                              ? const Color(0xFF1F1B18)
                                              : Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Options Grid
                        Row(
                          children: [
                            Expanded(
                              child: _smallOptionCard(
                                context: context,
                                icon: LucideIcons.settings,
                                text: "Settings",
                                isDark: isDark,
                                onTap: () => controller.selectMenu("Settings"),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _smallOptionCard(
                                context: context,
                                icon: LucideIcons.shield,
                                text: "Privacy",
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
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        Row(
                          children: [
                            Expanded(
                              child: _smallOptionCard(
                                context: context,
                                icon: LucideIcons.info,
                                text: "About App",
                                isDark: isDark,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AboutAppScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _smallOptionCard(
                                context: context,
                                icon: LucideIcons.logOut,
                                text: "Logout",
                                isDark: isDark,
                                isLogout: true,
                                onTap: () => _handleLogout(context, isDark),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Floating AppBar
            Positioned(
              top: 5,
              left: 6,
              right: 6,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1F1B18)
                      : const Color(0xFFE6DAC6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => controller.selectMenu("Dashboard"),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: isDark
                              ? const Color(0xFFE29B4B)
                              : const Color(0xFFB87333),
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? const Color(0xFFF5E6C8)
                            : const Color(0xFF3B2E1A),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ✅ FIXED LOGOUT HANDLER
  Future<void> _handleLogout(BuildContext context, bool isDark) async {
    // Show confirmation dialog
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor:
            isDark ? const Color(0xFF1F1B18) : const Color(0xFFE6DAC6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Logout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? const Color(0xFFF5E6C8) : const Color(0xFF3B2E1A),
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: TextStyle(
            color: isDark
                ? const Color(0xFFF5E6C8).withOpacity(0.8)
                : const Color(0xFF3B2E1A).withOpacity(0.8),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: isDark
                    ? const Color(0xFFF5E6C8).withOpacity(0.8)
                    : const Color(0xFF3B2E1A).withOpacity(0.8),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    // ✅ If confirmed, just sign out - AuthGate handles the rest
    if (shouldLogout == true) {
      await FirebaseAuth.instance.signOut();
      // NO manual navigation - AuthGate automatically shows LoginScreen
    }
  }

  Widget _smallOptionCard({
    required BuildContext context,
    required IconData icon,
    required String text,
    required bool isDark,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: isLogout
              ? (isDark
                  ? const Color(0xFF8B2020).withOpacity(0.8)
                  : const Color(0xFFE53935).withOpacity(0.9))
              : (isDark ? const Color(0xFF1F1B18) : const Color(0xFFE6DAC6)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isLogout
                    ? Colors.white.withOpacity(0.15)
                    : (isDark
                        ? const Color(0xFF2C1A12).withOpacity(0.5)
                        : const Color(0xFFF3E0C2).withOpacity(0.5)),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: isLogout
                    ? Colors.white
                    : (isDark
                        ? const Color(0xFFE29B4B)
                        : const Color(0xFFB87333)),
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isLogout
                    ? Colors.white
                    : (isDark
                        ? const Color(0xFFF5E6C8)
                        : const Color(0xFF3B2E1A)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
