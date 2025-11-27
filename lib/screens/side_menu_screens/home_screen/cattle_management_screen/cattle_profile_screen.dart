// screens/cattle_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:cattle_pulse/screens/side_menu_screens/home_screen/cattle_management_screen/cattle_model.dart';
import 'edit_feeding_profile_screen.dart';

class CattleProfileScreen extends StatelessWidget {
  final CattleModel cow;

  const CattleProfileScreen({super.key, required this.cow});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cattle Profile"),
        centerTitle: true,
        elevation: 0,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.share))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary,
                    colorScheme.primary.withOpacity(0.7)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child:
                        Icon(Icons.pets, size: 48, color: colorScheme.primary),
                  ),
                  const SizedBox(height: 16),
                  Text(cow.name,
                      style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 4),
                  Text(cow.tagId,
                      style: TextStyle(
                          fontSize: 16, color: Colors.white.withOpacity(0.9))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionCard(
                    title: "Basic Information",
                    icon: Icons.info_outline,
                    child: Column(
                      children: [
                        _ProfileInfoRow(
                            icon: Icons.category,
                            label: "Breed",
                            value: cow.breed),
                        _ProfileInfoRow(
                            icon: Icons.cake,
                            label: "Age",
                            value: "${cow.ageMonths} months"),
                        _ProfileInfoRow(
                            icon: Icons.monitor_weight,
                            label: "Weight",
                            value: "${cow.weightKg} kg"),
                        _ProfileInfoRow(
                            icon: Icons.favorite,
                            label: "Health Status",
                            value: cow.healthStatus),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _SectionCard(
                    title: "Auto Feeder Profile",
                    icon: Icons.restaurant,
                    child: Column(
                      children: [
                        _ProfileInfoRow(
                            icon: Icons.fastfood,
                            label: "Feed Type",
                            value: cow.feederProfile.feedType),
                        _ProfileInfoRow(
                            icon: Icons.scale,
                            label: "Total Feed",
                            value: "${cow.feederProfile.totalFeedKg} Kg"),
                        const SizedBox(height: 12),
                        _FeedCompositionBar(
                          items: [
                            _FeedItem("Hay", cow.feederProfile.hayPercent,
                                const Color(0xFFFFD54F)),
                            _FeedItem("Binola", cow.feederProfile.binolaPercent,
                                const Color(0xFFFF8A65)),
                            _FeedItem("Chokar", cow.feederProfile.chokarPercent,
                                const Color(0xFF81C784)),
                            _FeedItem(
                                "Makai",
                                cow.feederProfile.makaiLeavesPercent,
                                const Color(0xFF64B5F6)),
                            _FeedItem("Water", cow.feederProfile.waterPercent,
                                const Color(0xFF4FC3F7)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _FeedPercentageRow("Hay", cow.feederProfile.hayPercent,
                            const Color(0xFFFFD54F)),
                        _FeedPercentageRow(
                            "Binola",
                            cow.feederProfile.binolaPercent,
                            const Color(0xFFFF8A65)),
                        _FeedPercentageRow(
                            "Chokar",
                            cow.feederProfile.chokarPercent,
                            const Color(0xFF81C784)),
                        _FeedPercentageRow(
                            "Makai Leaves",
                            cow.feederProfile.makaiLeavesPercent,
                            const Color(0xFF64B5F6)),
                        _FeedPercentageRow(
                            "Water",
                            cow.feederProfile.waterPercent,
                            const Color(0xFF4FC3F7)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditFeedingProfileScreen(cattle: cow),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit Feeding Profile"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.history),
                    label: const Text("View Health History"),
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _SectionCard(
      {required this.title, required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: colorScheme.primary, size: 22),
                const SizedBox(width: 8),
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileInfoRow(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text("$label:",
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.grey[700])),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _FeedItem {
  final String name;
  final int percent;
  final Color color;

  _FeedItem(this.name, this.percent, this.color);
}

class _FeedCompositionBar extends StatelessWidget {
  final List<_FeedItem> items;

  const _FeedCompositionBar({required this.items});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: items
            .map((item) => Expanded(
                flex: item.percent,
                child: Container(height: 12, color: item.color)))
            .toList(),
      ),
    );
  }
}

class _FeedPercentageRow extends StatelessWidget {
  final String label;
  final int percent;
  final Color color;

  const _FeedPercentageRow(this.label, this.percent, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(4))),
          const SizedBox(width: 8),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
          Text("$percent%",
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }
}
