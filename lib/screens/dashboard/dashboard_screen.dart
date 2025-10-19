import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cattle_pulse/controllers/menu_app_controller.dart';
import 'package:cattle_pulse/themes/theme_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFF7F9F6),
      appBar: AppBar(
        backgroundColor:
            isDark ? const Color(0xFF1E1E1E) : const Color(0xFFE8F5E9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFFD4AF37)),
          onPressed: () => context.read<MenuAppController>().controlMenu(),
        ),
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
      ),

      // 📊 Main Dashboard Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🌿 TOP KPI CARDS
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: const [
                DashboardCard(title: "Total Cattle", value: "25", icon: Icons.pets),
                DashboardCard(title: "Healthy", value: "22", icon: Icons.favorite),
                DashboardCard(title: "Sick", value: "3", icon: Icons.warning_amber),
                DashboardCard(title: "Feeding Alerts", value: "2", icon: Icons.restaurant),
                DashboardCard(title: "Geo-Fence Alerts", value: "1", icon: Icons.location_on),
                DashboardCard(title: "Milk Collected", value: "50 L", icon: Icons.local_drink),
              ],
            ),
            const SizedBox(height: 30),

            // 📋 SECTION HEADER
            Text(
              "Farm Overview",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 15),

            // 📊 FARM DATA OVERVIEW SECTIONS
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🐄 Health Analytics Placeholder
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [const Color(0xFF2E2E2E), const Color(0xFF1B5E20)]
                            : [const Color(0xFFA5D6A7), const Color(0xFFFFF9C4)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.monitor_heart, color: Colors.white, size: 36),
                        const SizedBox(height: 8),
                        Text(
                          "Health Analytics",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "22 Healthy | 3 Sick",
                          style: TextStyle(
                            color: isDark ? Colors.white70 : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 🥛 Milk Production Overview
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [const Color(0xFF3E3E3E), const Color(0xFF2E7D32)]
                            : [const Color(0xFFFFF59D), const Color(0xFFAED581)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.local_drink, color: Colors.white, size: 36),
                        const SizedBox(height: 8),
                        Text(
                          "Milk Production",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "50 L Collected Today",
                          style: TextStyle(
                            color: isDark ? Colors.white70 : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // 🗺️ GEO-FENCING SECTION
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF263238) : const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Geo-Fencing Overview",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: isDark ? Colors.white : const Color(0xFF1B5E20),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/farm_map.png"), // Add map image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "1 animal out of safe zone ⚠️",
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 🔔 RECENT NOTIFICATIONS
            Text(
              "Recent Activities",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 10),

            Column(
              children: [
                _notificationTile(Icons.health_and_safety, "Cow #12 needs health check", "5 min ago", isDark),
                _notificationTile(Icons.local_drink, "Milk yield updated to 50L", "30 min ago", isDark),
                _notificationTile(Icons.map, "Cow #7 left fenced zone", "1 hour ago", isDark),
              ],
            ),

            const SizedBox(height: 30),

            // ⚙️ QUICK ACTIONS
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _quickAction(Icons.assignment, "View Reports", isDark),
                _quickAction(Icons.add_circle_outline, "Add New Cattle", isDark),
                _quickAction(Icons.fence, "Update Geo-Fencing", isDark),
                _quickAction(Icons.settings, "System Config", isDark),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔔 NOTIFICATION TILE BUILDER
  Widget _notificationTile(IconData icon, String title, String time, bool isDark) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFD4AF37)),
      title: Text(
        title,
        style: TextStyle(color: isDark ? Colors.white : Colors.black),
      ),
      subtitle: Text(
        time,
        style: TextStyle(color: isDark ? Colors.white60 : Colors.black54, fontSize: 12),
      ),
    );
  }

  // ⚙️ QUICK ACTION TILE BUILDER
  Widget _quickAction(IconData icon, String label, bool isDark) {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFFDE7),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black26
                : const Color(0xFF2E7D32).withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFFD4AF37), size: 28),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// 🧩 REUSABLE DASHBOARD CARD
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
              ? [const Color(0xFF4E5E4E), const Color(0xFF2E2E2E)]
              : [const Color(0xFFA3B18A), const Color(0xFFD4AF37)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                isDark ? Colors.black26 : const Color(0xFF2E7D32).withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 28),
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
            style: const TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
