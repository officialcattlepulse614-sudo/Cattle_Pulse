// lib/screens/main/home_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cattle_pulse/controllers/menu_app_controller.dart';
import 'package:cattle_pulse/screens/main/components/side_menu.dart';
import 'package:cattle_pulse/screens/profile_screen/profile_menu.dart';
import 'package:cattle_pulse/widgets/screen_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const HomeScreen({super.key, required this.themeNotifier});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? lastPressed;

  Future<bool> _onWillPop(MenuAppController menuController) async {
    if (menuController.selectedMenu != "Dashboard") {
      menuController.updateMenu("Dashboard");
      return false;
    }

    final now = DateTime.now();
    if (lastPressed == null ||
        now.difference(lastPressed!) > const Duration(seconds: 2)) {
      lastPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('home_screen.press_back_again'.tr()),
          duration: const Duration(seconds: 2),
        ),
      );
      return false;
    }

    final shouldExit = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;

        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor:
              isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF8F8F8),
          title: Row(
            children: [
              Icon(Icons.exit_to_app,
                  color: isDark
                      ? const Color(0xFFE29B4B)
                      : const Color(0xFFB87333)),
              const SizedBox(width: 8),
              Text(
                'home_screen.exit_app'.tr(),
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'home_screen.exit_app_message'.tr(),
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black87,
              height: 1.4,
            ),
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor:
                    isDark ? const Color(0xFFE29B4B) : const Color(0xFFB87333),
              ),
              onPressed: () => Navigator.pop(context, false),
              child: const Text(
                'Cancel',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isDark ? const Color(0xFFE29B4B) : const Color(0xFFB87333),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text(
                'Exit',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ],
        );
      },
    );

    if (shouldExit ?? false) {
      exit(0);
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuAppController>(
      builder: (context, menuController, child) {
        final theme = Theme.of(context);
        final bool isDark = theme.brightness == Brightness.dark;

        final bool showAppBar = !menuController.isProfileScreen;

        // Transparent system bars
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          systemNavigationBarIconBrightness:
              isDark ? Brightness.light : Brightness.dark,
        ));

        return WillPopScope(
          onWillPop: () => _onWillPop(menuController),
          child: Scaffold(
            key: menuController.scaffoldKey,
            drawer: SideMenu(themeNotifier: widget.themeNotifier),
            drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.12,

            // ----------------------------------------------------------
            // FLOATING APPBAR SECTION (UPDATED)
            // ----------------------------------------------------------
            appBar: showAppBar
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(50),
                    child: SafeArea(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 6, right: 6),
                        child: Material(
                          elevation: 8,
                          shadowColor: Colors.black26,
                          borderRadius: BorderRadius.circular(20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: AppBar(
                              elevation: 0,
                              backgroundColor: isDark
                                  ? const Color(0xFF1F1B18)
                                  : const Color(0xFFE6DAC6),
                              surfaceTintColor: Colors.transparent,
                              title: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  menuController.selectedMenu,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                              ),
                              leading: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: IconButton(
                                  icon: Icon(Icons.menu_rounded,
                                      color: isDark
                                          ? const Color(0xFFE29B4B)
                                          : const Color(0xFFB87333)),
                                  onPressed: menuController.controlMenu,
                                  tooltip: 'home_screen.menu'.tr(),
                                ),
                              ),
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 16, top: 8, bottom: 8),
                                  child: ProfileMenu(
                                    iconColor: isDark
                                        ? const Color(0xFFE29B4B)
                                        : const Color(0xFFB87333),
                                    themeNotifier: widget.themeNotifier,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : null,
            // ----------------------------------------------------------

            backgroundColor: Colors.transparent,
            body: ScreenWrapper(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                              begin: const Offset(0.02, 0), end: Offset.zero)
                          .animate(animation),
                      child: child,
                    ),
                  );
                },
                child: menuController.currentScreen,
              ),
            ),
          ),
        );
      },
    );
  }
}
