import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cattle_pulse/models/disease_data.dart';

class DiseaseScreen extends StatefulWidget {
  const DiseaseScreen({super.key});

  @override
  State<DiseaseScreen> createState() => _DiseaseScreenState();
}

class _DiseaseScreenState extends State<DiseaseScreen> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Filter based on search query
    final filteredDiseases = cattleDiseases
        .where((d) =>
            d.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
            d.symptoms.any((s) =>
                s.toLowerCase().contains(searchQuery.toLowerCase())))
        .toList();

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFFFFBF5),
      body: SafeArea(
        child: Column(
          children: [
            // 🔍 Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: tr('search_disease'),
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor:
                      isDark ? Colors.grey[900] : Colors.brown.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) => setState(() => searchQuery = value),
              ),
            ),

            // 🩺 Disease List
            Expanded(
              child: filteredDiseases.isEmpty
                  ? Center(
                      child: Text(
                        tr('no_disease_found'),
                        style: const TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredDiseases.length,
                      itemBuilder: (context, index) {
                        final disease = filteredDiseases[index];
                        return Card(
                          color: isDark
                              ? const Color(0xFF1E1E1E)
                              : const Color(0xFFFFFFFF),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ListTile(
                            leading: Icon(
                              disease.needsVet
                                  ? Icons.local_hospital_rounded
                                  : Icons.healing_rounded,
                              color: disease.needsVet
                                  ? Colors.redAccent
                                  : const Color(0xFFB87333),
                            ),
                            title: Text(
                              disease.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "${tr('symptoms')}: ${disease.symptoms.join(', ')}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                size: 16, color: Colors.grey),
                            onTap: () => _showDiseaseDialog(context, disease),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // 🧾 Popup Dialog for Cure Steps
  void _showDiseaseDialog(BuildContext context, Disease disease) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(disease.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                tr('treatment_steps'),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: 8),
              ...disease.cureSteps
                  .map((step) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text("• $step"),
                      ))
                  .toList(),
              const SizedBox(height: 15),
              if (disease.needsVet)
                Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded,
                        color: Colors.redAccent, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      tr('vet_required'),
                      style: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text(tr('close')),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
