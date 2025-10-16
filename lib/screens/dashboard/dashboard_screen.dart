import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cattle_pulse/controllers/menu_app_controller.dart'; // ✅ For Drawer control
import 'package:cattle_pulse/themes/theme_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF1C1C1C) : const Color(0xFFF7F9F6),
      appBar: AppBar(
        backgroundColor:
            isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE8F5E9),
        elevation: 0,

        // 🍔 Left-side drawer button
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFFD4AF37)),
          onPressed: () => context.read<MenuAppController>().controlMenu(),
        ),

        // 🐮 Title section
        title: Row(
          children: [
            const Icon(Icons.dashboard_rounded, color: Color(0xFFD4AF37)),
            const SizedBox(width: 8),
            Text(
              "Cattle Pulse Dashboard",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: isDark ? Colors.white : const Color(0xFF1E1E1E),
              ),
            ),
          ],
        ),

        // ❌ Removed right-side icons for clean FYP look
        // actions: [],
      ),

      // 📊 Dashboard content
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🌿 Top Summary Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                DashboardCard(
                  title: "Total Cattle",
                  value: "25",
                  icon: Icons.pets,
                ),
                DashboardCard(
                  title: "Healthy",
                  value: "22",
                  icon: Icons.favorite,
                ),
                DashboardCard(
                  title: "Sick",
                  value: "3",
                  icon: Icons.warning_amber,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 🍽️ Feeding Alerts & Milk Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                DashboardCard(
                  title: "Feeding Alerts",
                  value: "2",
                  icon: Icons.restaurant,
                ),
                DashboardCard(
                  title: "Milk Collected",
                  value: "50 L",
                  icon: Icons.local_drink,
                ),
              ],
            ),
            const SizedBox(height: 30),

            // 📋 Section Header
            Text(
              "Farm Overview",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 15),

            // 📈 Placeholder Section
            Expanded(
              child: Center(
                child: Text(
                  "Dashboard Analytics and Reports Coming Soon...",
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? Colors.white70 : Colors.black54,
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

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      height: 110,
      width: 110,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [
                  const Color(0xFF4E5E4E),
                  const Color(0xFF2E2E2E),
                ]
              : [
                  const Color(0xFFA3B18A),
                  const Color(0xFFD4AF37),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black26
                : const Color(0xFF2E7D32).withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
