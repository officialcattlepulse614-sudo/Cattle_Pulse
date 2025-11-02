import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cattle_pulse/controllers/menu_app_controller.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key, required this.themeNotifier}) : super(key: key);

  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final menuController = context.read<MenuAppController>();
    final size = MediaQuery.of(context).size;
    final bool isDark = theme.brightness == Brightness.dark;

    // Background gradient
    final Gradient backgroundGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark
          ? const [Color(0xFF1B1A18), Color(0xFF241E1A), Color(0xFF2C1A12)]
          : const [Color(0xFFF9EBD4), Color(0xFFF3E0C2), Color(0xFFEBD1A3)],
    );

    return Drawer(
      width: size.width < 700 ? 260 : 320,
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
                              style: theme.textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Text('Management System',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.85),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  children: [
                    const _DrawerSectionTitle(label: 'Main'),
                    DrawerListTile(
                      title: 'Dashboard',
                      icon: LucideIcons.layoutDashboard,
                      press: () => menuController.selectMenu('Dashboard'),
                      menuController: menuController,
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
                    DrawerListTile(
                      title: 'Geo Fencing',
                      icon: LucideIcons.mapPin,
                      press: () => menuController.selectMenu('Geo Fencing'),
                      menuController: menuController,
                    ),
                    DrawerListTile(
                      title: 'Reports',
                      icon: LucideIcons.fileBarChart,
                      press: () => menuController.selectMenu('Reports'),
                      menuController: menuController,
                    ),
                    const SizedBox(height: 6),
                    DrawerListTile(
                      title: 'Settings',
                      icon: LucideIcons.settings,
                      press: () => menuController.selectMenu('Settings'),
                      menuController: menuController,
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(
                        thickness: 0.8,
                        height: 24,
                        color: theme.dividerColor.withOpacity(
                          isDark ? 0.2 : 0.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                child: Column(
                  children: [
                    ValueListenableBuilder<ThemeMode>(
                      valueListenable: themeNotifier,
                      builder: (context, mode, child) {
                        final isDarkMode = mode == ThemeMode.dark;
                        final Color activeColor = isDarkMode
                            ? const Color(0xFFE29B4B)
                            : const Color(0xFFB87333);
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                              isDarkMode ? LucideIcons.moon : LucideIcons.sun,
                              color: activeColor),
                          title: Text('Theme Mode',
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          trailing: Switch(
                            value: isDarkMode,
                            onChanged: (v) => themeNotifier.value =
                                v ? ThemeMode.dark : ThemeMode.light,
                            activeThumbColor: activeColor,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 6),
                    Text('v1.0 • © Cattle Pulse',
                        style: theme.textTheme.bodySmall),
                    const SizedBox(height: 6),
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

// Section Title
class _DrawerSectionTitle extends StatelessWidget {
  const _DrawerSectionTitle({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Text(label.toUpperCase(),
          style: theme.textTheme.labelSmall
              ?.copyWith(fontWeight: FontWeight.w700, letterSpacing: 0.8)),
    );
  }
}

// Main Drawer Tile
class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.press,
    required this.menuController,
    this.trailing,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback press;
  final MenuAppController menuController;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: menuController,
      builder: (context, _) {
        final isSelected = _isSelected();

        // Better contrast selection background
        final BoxDecoration selectedDecoration = BoxDecoration(
          color: isDark
              ? theme.colorScheme.primary.withOpacity(0.18)
              : const Color.fromARGB(241, 253, 212, 179).withOpacity(0.55),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: isDark
                    ? theme.colorScheme.primary.withOpacity(0.25)
                    : Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
          ],
          border: isSelected
              ? Border.all(
                  color: isDark
                      ? theme.colorScheme.primary.withOpacity(0.3)
                      : Colors.brown.withOpacity(0.25),
                )
              : null,
        );

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
          decoration: isSelected
              ? selectedDecoration
              : const BoxDecoration(color: Colors.transparent),
          child: ListTile(
            onTap: press,
            dense: true,
            horizontalTitleGap: 8.0,
            minLeadingWidth: 28,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            leading: Icon(
              icon,
              color: isSelected
                  ? (isDark
                      ? theme.colorScheme.onPrimary
                      : Colors.brown.shade800)
                  : theme.colorScheme.onSurface.withOpacity(0.9),
              size: 20,
            ),
            title: Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected
                    ? (isDark
                        ? theme.colorScheme.onPrimary
                        : Colors.brown.shade900)
                    : theme.colorScheme.onSurface,
              ),
            ),
            trailing: trailing,
          ),
        );
      },
    );
  }

  bool _isSelected() {
    try {
      final selected = menuController.selectedMenu as String?;
      return selected != null && selected == title;
    } catch (_) {
      return false;
    }
  }
}

// Expandable Groups
class _ExpandableDrawerTile extends StatefulWidget {
  const _ExpandableDrawerTile(
      {Key? key,
      required this.title,
      required this.icon,
      required this.children})
      : super(key: key);

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  State<_ExpandableDrawerTile> createState() => _ExpandableDrawerTileState();
}

class _ExpandableDrawerTileState extends State<_ExpandableDrawerTile> {
  bool _open = false;
  late MenuAppController _menuCtrl;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _menuCtrl = context.read<MenuAppController>();
    _open = _menuCtrl.isInGroup(widget.title);
    _menuCtrl.removeListener(_onMenuChanged);
    _menuCtrl.addListener(_onMenuChanged);
  }

  void _onMenuChanged() {
    final shouldOpen = _menuCtrl.isInGroup(widget.title);
    if (mounted && shouldOpen != _open) {
      setState(() => _open = shouldOpen);
    }
  }

  @override
  void dispose() {
    _menuCtrl.removeListener(_onMenuChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        key: PageStorageKey(widget.title),
        initiallyExpanded: _open,
        onExpansionChanged: (v) => setState(() => _open = v),
        tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        childrenPadding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        leading: Icon(widget.icon,
            size: 20, color: theme.colorScheme.onSurface.withOpacity(0.9)),
        title: Text(widget.title,
            style: theme.textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.w700)),
        children: widget.children,
      ),
    );
  }
}

// Sub Items
class _DrawerSubItem extends StatelessWidget {
  const _DrawerSubItem(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onTap,
      required this.menuController})
      : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final MenuAppController menuController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: menuController,
      builder: (context, _) {
        final isSelected = _isSelected();
        return ListTile(
          onTap: onTap,
          dense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
          leading: Icon(
            icon,
            size: 18,
            color: isSelected
                ? (isDark ? theme.colorScheme.onPrimary : Colors.brown.shade800)
                : theme.colorScheme.onSurface.withOpacity(0.85),
          ),
          title: Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected
                  ? (isDark
                      ? theme.colorScheme.onPrimary
                      : Colors.brown.shade900)
                  : theme.colorScheme.onSurface,
            ),
          ),
          trailing: isSelected
              ? Icon(LucideIcons.check,
                  size: 16,
                  color: isDark
                      ? theme.colorScheme.onPrimary
                      : Colors.brown.shade800)
              : null,
        );
      },
    );
  }

  bool _isSelected() {
    try {
      final selected = menuController.selectedMenu as String?;
      return selected != null && selected == title;
    } catch (_) {
      return false;
    }
  }
}
