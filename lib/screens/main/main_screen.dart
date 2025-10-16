import 'package:cattle_pulse/controllers/menu_app_controller.dart';
import 'package:cattle_pulse/responsive.dart';
import 'package:cattle_pulse/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final menuController = context.read<MenuAppController>();

    return Scaffold(
      key: menuController.scaffoldKey,
      drawer: const SideMenu(),

      // 👇 Allow swipe to open the drawer even when swiping a bit away from edge
      drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.12,
      // 🔸 12% of the screen width (increase if you want more sensitivity)
      // Default Flutter value is ~20 pixels only

      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🌐 Show side menu permanently only on Desktop view
            if (Responsive.isDesktop(context))
              const Expanded(
                child: SideMenu(),
              ),

            // 📱 Main Content Area (Dashboard Screen)
            const Expanded(
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
