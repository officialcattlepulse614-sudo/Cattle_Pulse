import 'package:cattle_pulse/controllers/menu_app_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuAppController>(
      builder: (context, controller, child) {
        final titleColor = Theme.of(context).textTheme.titleLarge?.color ??
            Theme.of(context).colorScheme.onSurface;

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.dashboard_rounded,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 20),
              Text(
                "",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              Text(
                controller.selectedMenu,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: titleColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
