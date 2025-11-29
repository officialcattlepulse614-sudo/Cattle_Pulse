// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:cattle_pulse/controllers/theme_provider.dart';

// class ThemeAppearance extends StatelessWidget {
//   const ThemeAppearance({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//     final provider = Provider.of<ThemeProvider>(context);
//     ThemeMode currentMode = provider.themeMode;

//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
//     ));

//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // 🔹 Floating AppBar
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
//               child: Material(
//                 elevation: 8,
//                 shadowColor: Colors.black26,
//                 borderRadius: BorderRadius.circular(20),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: Container(
//                     height: 50,
//                     color: isDark
//                         ? const Color(0xFF1F1B18)
//                         : const Color.fromARGB(255, 230, 218, 198),
//                     child: Row(
//                       children: [
//                         IconButton(
//                           icon: Icon(
//                             Icons.arrow_back_ios_new_rounded,
//                             color: isDark
//                                 ? const Color(0xFFE29B4B)
//                                 : const Color(0xFFB87333),
//                           ),
//                           onPressed: () => Navigator.pop(context),
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           'Theme & Appearance',
//                           style: theme.textTheme.titleLarge?.copyWith(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 22,
//                             letterSpacing: 0.8,
//                             color: isDark
//                                 ? const Color(0xFFF5E6C8)
//                                 : const Color(0xFF3B2E1A),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // 🔹 Theme Options
//             RadioListTile<ThemeMode>(
//               title: const Text("Light Mode"),
//               value: ThemeMode.light,
//               groupValue: currentMode,
//               onChanged: (value) {
//                 provider.setTheme(ThemeMode.light);
//               },
//             ),

//             RadioListTile<ThemeMode>(
//               title: const Text("Dark Mode"),
//               value: ThemeMode.dark,
//               groupValue: currentMode,
//               onChanged: (value) {
//                 provider.setTheme(ThemeMode.dark);
//               },
//             ),

//             RadioListTile<ThemeMode>(
//               title: const Text("System Default"),
//               value: ThemeMode.system,
//               groupValue: currentMode,
//               onChanged: (value) {
//                 provider.setTheme(ThemeMode.system);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cattle_pulse/controllers/theme_provider.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ThemeAppearance extends StatefulWidget {
  const ThemeAppearance({super.key});

  @override
  State<ThemeAppearance> createState() => _ThemeAppearanceState();
}

class _ThemeAppearanceState extends State<ThemeAppearance>
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
    final provider = Provider.of<ThemeProvider>(context);
    final currentMode = provider.themeMode;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    ));

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
                            color: isDark
                                ? const Color(0xFFE29B4B)
                                : const Color(0xFFB87333),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Theme & Appearance',
                          style: theme.textTheme.titleLarge?.copyWith(
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

            const SizedBox(height: 20),

            // Content
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Section
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
                            borderRadius: BorderRadius.circular(20),
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
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFFE29B4B).withOpacity(0.2)
                                      : const Color(0xFFB87333)
                                          .withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isDark
                                        ? const Color(0xFFE29B4B)
                                            .withOpacity(0.3)
                                        : const Color(0xFFB87333)
                                            .withOpacity(0.3),
                                    width: 1.5,
                                  ),
                                ),
                                child: Icon(
                                  LucideIcons.palette,
                                  color: isDark
                                      ? const Color(0xFFE29B4B)
                                      : const Color(0xFFB87333),
                                  size: 32,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Appearance',
                                      style: theme.textTheme.headlineSmall
                                          ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: isDark
                                            ? const Color(0xFFF5E6C8)
                                            : const Color(0xFF3B2E1A),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Customize your visual experience',
                                      style:
                                          theme.textTheme.bodyMedium?.copyWith(
                                        color: isDark
                                            ? const Color(0xFFF5E6C8)
                                                .withOpacity(0.7)
                                            : const Color(0xFF3B2E1A)
                                                .withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Section Label
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
                                'THEME OPTIONS',
                                style: theme.textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                  color: isDark
                                      ? const Color(0xFFF5E6C8).withOpacity(0.8)
                                      : const Color(0xFF3B2E1A)
                                          .withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Theme Options
                        _ThemeOptionCard(
                          icon: LucideIcons.sun,
                          title: 'Light Mode',
                          subtitle: 'Bright and clear interface for daytime',
                          themeMode: ThemeMode.light,
                          currentMode: currentMode,
                          isDark: isDark,
                          delay: 0,
                          onTap: () => provider.setTheme(ThemeMode.light),
                        ),

                        const SizedBox(height: 12),

                        _ThemeOptionCard(
                          icon: LucideIcons.moon,
                          title: 'Dark Mode',
                          subtitle: 'Reduced eye strain in low light',
                          themeMode: ThemeMode.dark,
                          currentMode: currentMode,
                          isDark: isDark,
                          delay: 100,
                          onTap: () => provider.setTheme(ThemeMode.dark),
                        ),

                        const SizedBox(height: 12),

                        _ThemeOptionCard(
                          icon: LucideIcons.smartphone,
                          title: 'System Default',
                          subtitle: 'Match your device settings',
                          themeMode: ThemeMode.system,
                          currentMode: currentMode,
                          isDark: isDark,
                          delay: 200,
                          onTap: () => provider.setTheme(ThemeMode.system),
                        ),

                        const SizedBox(height: 32),

                        // Preview Section
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
                                'LIVE PREVIEW',
                                style: theme.textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                  color: isDark
                                      ? const Color(0xFFF5E6C8).withOpacity(0.8)
                                      : const Color(0xFF3B2E1A)
                                          .withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Preview Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1F1B18)
                                : const Color(0xFFE6DAC6),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFF302518)
                                  : const Color(0xFFA89B85),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isDark
                                    ? Colors.black.withOpacity(0.4)
                                    : Colors.brown.withOpacity(0.15),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: isDark
                                            ? [
                                                const Color(0xFFE29B4B),
                                                const Color(0xFFD18A3A),
                                              ]
                                            : [
                                                const Color(0xFFB87333),
                                                const Color(0xFFA86222),
                                              ],
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: (isDark
                                                  ? const Color(0xFFE29B4B)
                                                  : const Color(0xFFB87333))
                                              .withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      LucideIcons.user,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Sample Card Title',
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: isDark
                                                ? const Color(0xFFF5E6C8)
                                                : const Color(0xFF3B2E1A),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Current theme preview',
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: isDark
                                                ? const Color(0xFFF5E6C8)
                                                    .withOpacity(0.7)
                                                : const Color(0xFF3B2E1A)
                                                    .withOpacity(0.7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    LucideIcons.sparkles,
                                    color: isDark
                                        ? const Color(0xFFE29B4B)
                                        : const Color(0xFFB87333),
                                    size: 20,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF2C1A12)
                                      : const Color(0xFFF3E0C2),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isDark
                                        ? const Color(0xFF3A2418)
                                        : const Color(0xFFD1B585),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          LucideIcons.info,
                                          size: 16,
                                          color: isDark
                                              ? const Color(0xFFE29B4B)
                                              : const Color(0xFFB87333),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Content Area',
                                          style: theme.textTheme.labelLarge
                                              ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: isDark
                                                ? const Color(0xFFF5E6C8)
                                                : const Color(0xFF3B2E1A),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'This is how text and content will appear with your selected theme. All colors adapt automatically.',
                                      style:
                                          theme.textTheme.bodySmall?.copyWith(
                                        color: isDark
                                            ? const Color(0xFFF5E6C8)
                                                .withOpacity(0.8)
                                            : const Color(0xFF3B2E1A)
                                                .withOpacity(0.8),
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? const Color(0xFFE29B4B)
                                            : const Color(0xFFB87333),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Primary Button',
                                          style: theme.textTheme.labelLarge
                                              ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: isDark
                                                ? const Color(0xFF1F1B18)
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: isDark
                                              ? const Color(0xFFE29B4B)
                                              : const Color(0xFFB87333),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Secondary',
                                          style: theme.textTheme.labelLarge
                                              ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: isDark
                                                ? const Color(0xFFE29B4B)
                                                : const Color(0xFFB87333),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                                LucideIcons.lightbulb,
                                size: 20,
                                color: isDark
                                    ? const Color(0xFFE29B4B)
                                    : const Color(0xFFB87333),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Your theme preference is automatically saved',
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final ThemeMode themeMode;
  final ThemeMode currentMode;
  final bool isDark;
  final int delay;
  final VoidCallback onTap;

  const _ThemeOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.themeMode,
    required this.currentMode,
    required this.isDark,
    required this.delay,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSelected = currentMode == themeMode;

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
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark
                    ? const Color(0xFFE29B4B).withOpacity(0.15)
                    : const Color(0xFFB87333).withOpacity(0.12))
                : (isDark ? const Color(0xFF1F1B18) : const Color(0xFFE6DAC6)),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? (isDark ? const Color(0xFFE29B4B) : const Color(0xFFB87333))
                  : (isDark
                      ? const Color(0xFF302518)
                      : const Color(0xFFA89B85)),
              width: isSelected ? 2 : 1.5,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: (isDark
                              ? const Color(0xFFE29B4B)
                              : const Color(0xFFB87333))
                          .withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withOpacity(0.2)
                          : Colors.brown.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: isDark
                              ? [
                                  const Color(0xFFE29B4B),
                                  const Color(0xFFD18A3A),
                                ]
                              : [
                                  const Color(0xFFB87333),
                                  const Color(0xFFA86222),
                                ],
                        )
                      : null,
                  color: !isSelected
                      ? (isDark
                          ? const Color(0xFF2C1A12)
                          : const Color(0xFFF3E0C2))
                      : null,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: (isDark
                                    ? const Color(0xFFE29B4B)
                                    : const Color(0xFFB87333))
                                .withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  icon,
                  color: isSelected
                      ? Colors.white
                      : (isDark
                          ? const Color(0xFFE29B4B)
                          : const Color(0xFFB87333)),
                  size: 26,
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
                        color: isSelected
                            ? (isDark
                                ? const Color(0xFFE29B4B)
                                : const Color(0xFFB87333))
                            : (isDark
                                ? const Color(0xFFF5E6C8)
                                : const Color(0xFF3B2E1A)),
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
              AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: isSelected ? 1.0 : 0.0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [
                              const Color(0xFFE29B4B),
                              const Color(0xFFD18A3A),
                            ]
                          : [
                              const Color(0xFFB87333),
                              const Color(0xFFA86222),
                            ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (isDark
                                ? const Color(0xFFE29B4B)
                                : const Color(0xFFB87333))
                            .withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
