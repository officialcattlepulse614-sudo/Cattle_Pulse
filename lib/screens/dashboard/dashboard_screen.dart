import 'package:cattle_pulse/controllers/menu_app_controller.dart';
import 'package:cattle_pulse/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ AppBar only for mobile & tablet, not for desktop
      appBar: Responsive.isDesktop(context)
          ? null
          : AppBar(
              backgroundColor:
                  Colors.white.withOpacity(0.85), // soft translucent
              elevation: 0,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(
                    Icons.menu_rounded,
                    size: 36, // thick and bold
                    weight: 900,
                    color: Colors.black,
                  ),
                  onPressed: () =>
                      context.read<MenuAppController>().controlMenu(),
                ),
              ),
              title: const Text(
                "Cattle Pulse Dashboard",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
      body: Center(
        child: Text(
          "Dashboard Content Goes Here",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
              ),
        ),
      ),
    );
  }
}
