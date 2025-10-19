import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cattle_pulse/themes/theme_provider.dart';

class MilkProductionScreen extends StatelessWidget {
  const MilkProductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFF7F9F6),
      appBar: AppBar(
        automaticallyImplyLeading: true, // ✅ shows default back arrow
        backgroundColor:
            isDark ? const Color(0xFF1E1E1E) : const Color(0xFFE8F5E9),
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.local_drink, color: Color(0xFFD4AF37)),
            const SizedBox(width: 8),
            Text(
              "Milk Production",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : const Color(0xFF1E1E1E),
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🌾 Summary Cards
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: const [
                MilkCard(title: "Today", value: "52 L", color: Color(0xFFD4AF37), icon: Icons.water_drop),
                MilkCard(title: "Avg/Cow", value: "2.6 L", color: Color(0xFF81C784), icon: Icons.pets),
                MilkCard(title: "Yesterday", value: "48 L", color: Color(0xFFFFB74D), icon: Icons.calendar_today),
                MilkCard(title: "Cows", value: "20", color: Color(0xFFE57373), icon: Icons.agriculture),
              ],
            ),
            const SizedBox(height: 30),

            // 📊 Chart
            Text(
              "Weekly Production Trend",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(2, 3),
                  ),
                ],
              ),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true, drawVerticalLine: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
                          return Text(
                            days[value.toInt() % 7],
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black54,
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: const Color(0xFFD4AF37),
                      barWidth: 3,
                      belowBarData: BarAreaData(
                        show: true,
                        color: const Color(0xFFD4AF37).withOpacity(0.2),
                      ),
                      spots: const [
                        FlSpot(0, 40),
                        FlSpot(1, 48),
                        FlSpot(2, 52),
                        FlSpot(3, 49),
                        FlSpot(4, 55),
                        FlSpot(5, 50),
                        FlSpot(6, 53),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // 🧺 Milk Collection List
            Text(
              "Today's Milk Collection",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 10),

            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: _milkCollectionList(isDark),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _milkCollectionList(bool isDark) {
    final data = [
      {"id": "C01", "time": "6:00 AM", "quantity": "2.5 L", "status": "Done"},
      {"id": "C02", "time": "6:10 AM", "quantity": "2.3 L", "status": "Done"},
      {"id": "C03", "time": "6:25 AM", "quantity": "2.0 L", "status": "Missed"},
      {"id": "C04", "time": "6:30 AM", "quantity": "2.7 L", "status": "Done"},
    ];

    return data.map((milk) {
      Color statusColor = milk["status"] == "Done" ? Colors.green : Colors.red;
      IconData icon = milk["status"] == "Done" ? Icons.check_circle : Icons.cancel;

      return Card(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: statusColor.withOpacity(0.2),
            child: Icon(icon, color: statusColor),
          ),
          title: Text(
            "Cattle ${milk['id']}",
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "${milk['time']}  •  ${milk['quantity']}",
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
          trailing: Text(
            milk["status"]!,
            style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }).toList();
  }
}

class MilkCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const MilkCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      height: 100,
      width: 110,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.9), const Color(0xFFD4AF37)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
