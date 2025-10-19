import 'package:cattle_pulse/controllers/menu_app_controller.dart';
import 'package:cattle_pulse/screens/main/components/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const HomeScreen({super.key, required this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuAppController>(
      builder: (context, menuController, child) {
        return Scaffold(
          key: menuController.scaffoldKey,
          drawer: SideMenu(themeNotifier: themeNotifier),
          drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.12,
          appBar: AppBar(
            title: Text(
              menuController.selectedMenu,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.menu_rounded),
              onPressed: menuController.controlMenu,
            ),
            actions: [
              InkWell(
                onTap: () {
                  // Navigate to profile screen later
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.account_circle,
                      color: Theme.of(context).colorScheme.primary,
                      size: 35,
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: menuController.currentScreen,
            ),
          ),
        );
      },
    );
  }
}
