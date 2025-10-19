import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cattle_pulse/controllers/menu_app_controller.dart';
import 'package:cattle_pulse/screens/main/components/side_menu.dart';
import 'package:cattle_pulse/screens/dashboard/dashboard_screen.dart';
import 'package:cattle_pulse/themes/theme_provider.dart';

class MainScreen extends StatelessWidget {
  final Widget? child; // 👈 allow dynamic screen loading

  const MainScreen({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: const SideMenu(),
      backgroundColor:
          themeProvider.isDarkMode ? const Color(0xFF121212) : Colors.white,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖥️ Drawer (always visible on desktop)
            if (MediaQuery.of(context).size.width > 900)
              const Expanded(
                flex: 2,
                child: SideMenu(),
              ),

            // 📊 Dynamic content area
            Expanded(
              flex: 7,
              child: child ??
                  const DashboardScreen(), // 👈 fallback to Dashboard if no child is passed
            ),
          ],
        ),
      ),
    );
  }
}

