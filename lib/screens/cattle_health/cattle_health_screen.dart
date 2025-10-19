import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cattle_pulse/screens/main/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:cattle_pulse/themes/theme_provider.dart';

class CattleHealthScreen extends StatelessWidget {
  const CattleHealthScreen({super.key});

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
        title: Text(
          "Cattle Health Overview",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDark ? Colors.white : const Color(0xFF2E7D32)),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // 🐮 Header Info
            Text(
              "Cattle Health Summary",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 15),

            // 🧠 Graph Section
            Container(
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [const Color(0xFF355E3B), const Color(0xFF2E2E2E)]
                      : [const Color(0xFFA3B18A), const Color(0xFFD4AF37)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(2, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: LineChart(
                LineChartData(
                  backgroundColor: Colors.transparent,
                  titlesData: FlTitlesData(show: false),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: Colors.white,
                      barWidth: 3,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.3),
                            Colors.transparent
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      spots: const [
                        FlSpot(0, 2),
                        FlSpot(1, 3.2),
                        FlSpot(2, 2.8),
                        FlSpot(3, 4),
                        FlSpot(4, 3.7),
                        FlSpot(5, 4.5),
                        FlSpot(6, 3.9),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),

            // 🩺 Health Details Cards
            Wrap(
              spacing: 15,
              runSpacing: 15,
              children: const [
                HealthInfoCard(title: "Total Cattle", value: "25", icon: Icons.pets),
                HealthInfoCard(title: "Healthy", value: "22", icon: Icons.favorite),
                HealthInfoCard(title: "Sick", value: "3", icon: Icons.warning_amber),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HealthInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const HealthInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      width: 110,
      height: 110,
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
                isDark ? Colors.black26 : const Color(0xFF2E7D32).withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
