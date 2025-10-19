import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cattle_pulse/themes/theme_provider.dart';

class FeedingScheduleScreen extends StatelessWidget {
  const FeedingScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF1C1C1C) : const Color(0xFFF7F9F6),

      // 🧭 AppBar with Back Button
      appBar: AppBar(
        backgroundColor:
            isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE8F5E9),
        elevation: 0,
        automaticallyImplyLeading: false, // avoid duplicate buttons
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFD4AF37)),
          // ⏩ Use maybePop() ensures instant response
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          },
        ),
        title: Row(
          children: [
            const Icon(Icons.restaurant_menu, color: Color(0xFFD4AF37)),
            const SizedBox(width: 8),
            Text(
              "Feeding Schedule",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: isDark ? Colors.white : const Color(0xFF1E1E1E),
              ),
            ),
          ],
        ),
      ),

      // 📋 Main Body
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            // 🌿 Summary Cards
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  FeedingCard(title: "Total", value: "25", icon: Icons.pets),
                  SizedBox(width: 10),
                  FeedingCard(title: "Completed", value: "18", icon: Icons.check),
                  SizedBox(width: 10),
                  FeedingCard(title: "Missed", value: "3", icon: Icons.warning),
                  SizedBox(width: 10),
                  FeedingCard(title: "Upcoming", value: "4", icon: Icons.schedule),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 🍽 Feeding List
            Text(
              "Today's Feeding Schedule",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 10),

            ..._buildFeedingList(isDark),
          ],
        ),
      ),

      // ➕ Add Feeding Record Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFD4AF37),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Add Feeding Record Coming Soon!")),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // 🐄 Feeding List Builder
  List<Widget> _buildFeedingList(bool isDark) {
    final feedData = [
      {"id": "C1", "feed": "Grass + Mineral Mix", "time": "6:00 AM", "status": "Done"},
      {"id": "C2", "feed": "Grain + Water", "time": "8:00 AM", "status": "Missed"},
      {"id": "C3", "feed": "Hay + Water", "time": "12:00 PM", "status": "Pending"},
      {"id": "C4", "feed": "Dry Feed", "time": "4:00 PM", "status": "Done"},
    ];

    return feedData.map((feed) {
      Color statusColor;
      IconData statusIcon;

      switch (feed["status"]) {
        case "Done":
          statusColor = Colors.green;
          statusIcon = Icons.check_circle;
          break;
        case "Missed":
          statusColor = Colors.red;
          statusIcon = Icons.cancel;
          break;
        default:
          statusColor = Colors.orange;
          statusIcon = Icons.access_time;
      }

      return Card(
        color: isDark ? const Color(0xFF2E2E2E) : Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 6),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: statusColor.withOpacity(0.2),
            child: Icon(statusIcon, color: statusColor),
          ),
          title: Text(
            "Cattle ${feed['id']}",
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            "${feed['feed']}  •  ${feed['time']}",
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
          trailing: Text(
            feed["status"]!,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }).toList();
  }
}

// 💠 Reusable Summary Card Widget
class FeedingCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const FeedingCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      height: 100,
      width: 90,
      margin: const EdgeInsets.only(right: 8),
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
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(2, 3),
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
