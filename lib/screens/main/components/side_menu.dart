import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cattle_pulse/controllers/menu_app_controller.dart';
import 'package:cattle_pulse/controllers/theme_provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final menuController = context.read<MenuAppController>();
    final themeProvider = context.watch<ThemeProvider>();
    final size = MediaQuery.of(context).size;
    final bool isDark = theme.brightness == Brightness.dark;

    final Gradient backgroundGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark
          ? const [Color(0xFF1B1A18), Color(0xFF241E1A), Color(0xFF2C1A12)]
          : const [Color(0xFFF9EBD4), Color(0xFFF3E0C2), Color(0xFFEBD1A3)],
    );

    return Drawer(
      width: size.width < 900 ? 245 : 320,
      child: Container(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.35)
                  : Colors.brown.withOpacity(0.08),
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Logo & Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/cp2.png',
                      height: 56,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Cattle Pulse',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: isDark
                                    ? const Color(0xFFF5E6C8)
                                    : const Color(0xFF3B2E1A),
                              )),
                          const SizedBox(height: 4),
                          Text('Management System',
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? const Color(0xFFF5E6C8).withOpacity(0.85)
                                    : const Color(0xFF3B2E1A).withOpacity(0.85),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Divider after header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [
                              const Color(0xFFE29B4B).withOpacity(0.3),
                              const Color(0xFFE29B4B).withOpacity(0.7),
                              const Color(0xFFE29B4B).withOpacity(0.3),
                            ]
                          : [
                              const Color(0xFFB87333).withOpacity(0.3),
                              const Color(0xFFB87333).withOpacity(0.7),
                              const Color(0xFFB87333).withOpacity(0.3),
                            ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Menu Items
              Expanded(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  children: [
                    const _DrawerSectionTitle(label: 'Main'),
                    _ExpandableDrawerTile(
                      title: 'Home',
                      icon: LucideIcons.home,
                      children: [
                        _DrawerSubItem(
                          title: 'Dashboard',
                          icon: LucideIcons.layoutDashboard,
                          onTap: () => menuController.selectMenu('Dashboard'),
                          menuController: menuController,
                        ),
                        _DrawerSubItem(
                          title: 'Cattle Management',
                          icon: LucideIcons.clipboardList,
                          onTap: () =>
                              menuController.selectMenu('Cattle Management'),
                          menuController: menuController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Divider
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Container(
                        height: 1.5,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isDark
                                ? [
                                    const Color(0xFFE29B4B).withOpacity(0.2),
                                    const Color(0xFFE29B4B).withOpacity(0.5),
                                    const Color(0xFFE29B4B).withOpacity(0.2),
                                  ]
                                : [
                                    const Color(0xFFB87333).withOpacity(0.2),
                                    const Color(0xFFB87333).withOpacity(0.5),
                                    const Color(0xFFB87333).withOpacity(0.2),
                                  ],
                          ),
                        ),
                      ),
                    ),

                    _ExpandableDrawerTile(
                      title: 'Cattle Health',
                      icon: LucideIcons.heartPulse,
                      children: [
                        _DrawerSubItem(
                          title: 'Temperature Monitor',
                          icon: LucideIcons.thermometer,
                          onTap: () =>
                              menuController.selectMenu('Temperature Monitor'),
                          menuController: menuController,
                        ),
                        _DrawerSubItem(
                          title: 'Diagnosis & Treatment',
                          icon: LucideIcons.stethoscope,
                          onTap: () => menuController
                              .selectMenu('Diagnosis & Treatment'),
                          menuController: menuController,
                        ),
                        _DrawerSubItem(
                          title: 'Vaccination & Records',
                          icon: LucideIcons.clipboardList,
                          onTap: () => menuController
                              .selectMenu('Vaccination & Records'),
                          menuController: menuController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Divider
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Container(
                        height: 1.5,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isDark
                                ? [
                                    const Color(0xFFE29B4B).withOpacity(0.2),
                                    const Color(0xFFE29B4B).withOpacity(0.5),
                                    const Color(0xFFE29B4B).withOpacity(0.2),
                                  ]
                                : [
                                    const Color(0xFFB87333).withOpacity(0.2),
                                    const Color(0xFFB87333).withOpacity(0.5),
                                    const Color(0xFFB87333).withOpacity(0.2),
                                  ],
                          ),
                        ),
                      ),
                    ),

                    _ExpandableDrawerTile(
                      title: 'Cattle Feeding',
                      icon: LucideIcons.wheat,
                      children: [
                        _DrawerSubItem(
                          title: 'Feeding Schedule',
                          icon: LucideIcons.calendarClock,
                          onTap: () =>
                              menuController.selectMenu('Feeding Schedule'),
                          menuController: menuController,
                        ),
                        _DrawerSubItem(
                          title: 'Auto Feeder',
                          icon: LucideIcons.refreshCw,
                          onTap: () => menuController.selectMenu('Auto Feeder'),
                          menuController: menuController,
                        ),
                        _DrawerSubItem(
                          title: 'Inventory',
                          icon: LucideIcons.package,
                          onTap: () => menuController.selectMenu('Inventory'),
                          menuController: menuController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Divider
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Container(
                        height: 1.5,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isDark
                                ? [
                                    const Color(0xFFE29B4B).withOpacity(0.2),
                                    const Color(0xFFE29B4B).withOpacity(0.5),
                                    const Color(0xFFE29B4B).withOpacity(0.2),
                                  ]
                                : [
                                    const Color(0xFFB87333).withOpacity(0.2),
                                    const Color(0xFFB87333).withOpacity(0.5),
                                    const Color(0xFFB87333).withOpacity(0.2),
                                  ],
                          ),
                        ),
                      ),
                    ),

                    DrawerListTile(
                      title: 'Geo Fencing',
                      icon: LucideIcons.mapPin,
                      press: () => menuController.selectMenu('Geo Fencing'),
                      menuController: menuController,
                    ),
                    const SizedBox(height: 6),

                    // Divider
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Container(
                        height: 1.5,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isDark
                                ? [
                                    const Color(0xFFE29B4B).withOpacity(0.2),
                                    const Color(0xFFE29B4B).withOpacity(0.5),
                                    const Color(0xFFE29B4B).withOpacity(0.2),
                                  ]
                                : [
                                    const Color(0xFFB87333).withOpacity(0.2),
                                    const Color(0xFFB87333).withOpacity(0.5),
                                    const Color(0xFFB87333).withOpacity(0.2),
                                  ],
                          ),
                        ),
                      ),
                    ),

                    DrawerListTile(
                      title: 'Reports',
                      icon: LucideIcons.fileBarChart,
                      press: () => menuController.selectMenu('Reports'),
                      menuController: menuController,
                    ),
                    const SizedBox(height: 6),

                    // Divider
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Container(
                        height: 1.5,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isDark
                                ? [
                                    const Color(0xFFE29B4B).withOpacity(0.2),
                                    const Color(0xFFE29B4B).withOpacity(0.5),
                                    const Color(0xFFE29B4B).withOpacity(0.2),
                                  ]
                                : [
                                    const Color(0xFFB87333).withOpacity(0.2),
                                    const Color(0xFFB87333).withOpacity(0.5),
                                    const Color(0xFFB87333).withOpacity(0.2),
                                  ],
                          ),
                        ),
                      ),
                    ),

                    DrawerListTile(
                      title: 'Settings',
                      icon: LucideIcons.settings,
                      press: () => menuController.selectMenu('Settings'),
                      menuController: menuController,
                    ),
                    const SizedBox(height: 8),

                    // Final Divider before footer
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isDark
                                ? [
                                    const Color(0xFFE29B4B).withOpacity(0.3),
                                    const Color(0xFFE29B4B).withOpacity(0.7),
                                    const Color(0xFFE29B4B).withOpacity(0.3),
                                  ]
                                : [
                                    const Color(0xFFB87333).withOpacity(0.3),
                                    const Color(0xFFB87333).withOpacity(0.7),
                                    const Color(0xFFB87333).withOpacity(0.3),
                                  ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),

              // Footer: Theme switch & Version
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF1F1B18).withOpacity(0.6)
                            : const Color(0xFFE6DAC6).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isDark ? LucideIcons.moon : LucideIcons.sun,
                            size: 20,
                            color: isDark
                                ? const Color(0xFFE29B4B)
                                : const Color(0xFFB87333),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Theme Mode',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: isDark
                                    ? const Color(0xFFF5E6C8)
                                    : const Color(0xFF3B2E1A),
                              ),
                            ),
                          ),
                          Switch(
                            value: isDark,
                            onChanged: (value) {
                              if (value) {
                                themeProvider.setTheme(ThemeMode.dark);
                              } else {
                                themeProvider.setTheme(ThemeMode.light);
                              }
                            },
                            activeThumbColor: isDark
                                ? const Color(0xFFE29B4B)
                                : const Color(0xFFB87333),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'v1.0 • © Cattle Pulse',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? const Color(0xFFF5E6C8).withOpacity(0.7)
                            : const Color(0xFF3B2E1A).withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Section Title Widget
class _DrawerSectionTitle extends StatelessWidget {
  final String label;
  const _DrawerSectionTitle({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      child: Text(
        label.toUpperCase(),
        style: theme.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 1.4,
          fontSize: 12,
          color: isDark ? const Color(0xFFE29B4B) : const Color(0xFFB87333),
        ),
      ),
    );
  }
}

// Expandable Drawer Tile
class _ExpandableDrawerTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _ExpandableDrawerTile({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  State<_ExpandableDrawerTile> createState() => _ExpandableDrawerTileState();
}

class _ExpandableDrawerTileState extends State<_ExpandableDrawerTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
            decoration: BoxDecoration(
              color: _isExpanded
                  ? (isDark
                      ? const Color(0xFF1F1B18).withOpacity(0.7)
                      : const Color(0xFFE6DAC6).withOpacity(0.5))
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  size: 20,
                  color: isDark
                      ? const Color(0xFFE29B4B)
                      : const Color(0xFFB87333),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: isDark
                          ? const Color(0xFFF5E6C8)
                          : const Color(0xFF3B2E1A),
                    ),
                  ),
                ),
                Icon(
                  _isExpanded
                      ? LucideIcons.chevronDown
                      : LucideIcons.chevronRight,
                  size: 18,
                  color: isDark
                      ? const Color(0xFFE29B4B)
                      : const Color(0xFFB87333),
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 2),
            child: Column(children: widget.children),
          ),
      ],
    );
  }
}

// Drawer Sub Item
class _DrawerSubItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final MenuAppController menuController;

  const _DrawerSubItem({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.menuController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final isSelected = menuController.selectedMenu == title;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFF1F1B18) : const Color(0xFFE6DAC6))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isDark ? const Color(0xFFE29B4B) : const Color(0xFFB87333),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  fontSize: 14,
                  color: isDark
                      ? const Color(0xFFF5E6C8)
                      : const Color(0xFF3B2E1A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Regular Drawer List Tile
class DrawerListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback press;
  final MenuAppController menuController;

  const DrawerListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.press,
    required this.menuController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final isSelected = menuController.selectedMenu == title;

    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFF1F1B18) : const Color(0xFFE6DAC6))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isDark ? const Color(0xFFE29B4B) : const Color(0xFFB87333),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  fontSize: 15,
                  color: isDark
                      ? const Color(0xFFF5E6C8)
                      : const Color(0xFF3B2E1A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
