import 'dart:ui';
import 'package:flutter/material.dart';

class LocalDiagnosisTestApp extends StatelessWidget {
  const LocalDiagnosisTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farm Health Guide',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF4CAF50),
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(fontSize: 15, height: 1.4),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white70),
          titleMedium: TextStyle(color: Colors.white),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const DiagnosisTreatmentScreen(),
    );
  }
}

class _DiseaseItem {
  final String name;
  final String short;
  final String symptoms;
  final String treatmentAtFarm;
  final bool vetRequired;
  final String precautions;

  const _DiseaseItem({
    required this.name,
    required this.short,
    required this.symptoms,
    required this.treatmentAtFarm,
    required this.vetRequired,
    required this.precautions,
  });
}

class DiagnosisTreatmentScreen extends StatefulWidget {
  const DiagnosisTreatmentScreen({super.key});

  @override
  State<DiagnosisTreatmentScreen> createState() =>
      _DiagnosisTreatmentScreenState();
}

class _DiagnosisTreatmentScreenState extends State<DiagnosisTreatmentScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';
  String _filter = 'All';
  late AnimationController _listAnimController;

  final List<_DiseaseItem> _allDiseases = const [
    _DiseaseItem(
      name: 'Mastitis',
      short: 'Udder infection — common after calving',
      symptoms: 'Swollen/hot udder, abnormal milk, fever, reduced yield',
      treatmentAtFarm:
          'Clean udder, frequent milking, apply warm compresses, consult vet for antibiotics.',
      vetRequired: true,
      precautions:
          'Maintain clean housing, proper milking hygiene, isolate affected animals.',
    ),
    _DiseaseItem(
      name: 'Foot-and-Mouth Disease (FMD)',
      short: 'Highly contagious viral disease',
      symptoms:
          'Fever, blisters on mouth/feet/teats, salivation, lameness, sudden drop in milk',
      treatmentAtFarm:
          'Isolate affected animals, supportive care (fluids, soft food), strict biosecurity.',
      vetRequired: true,
      precautions:
          'Control movement, disinfect pens, report to local animal health authorities.',
    ),
    _DiseaseItem(
      name: 'Bloat (Ruminal tympany)',
      short: 'Gas accumulation in rumen — can be life threatening',
      symptoms: 'Swelling on left flank, discomfort, difficulty breathing',
      treatmentAtFarm:
          'Move animal to stand, pass an ororuminal tube if trained, give anti-foaming agents (poloxalene).',
      vetRequired: true,
      precautions:
          'Avoid sudden diet changes, limit access to lush legumes, feed slowly.',
    ),
    _DiseaseItem(
      name: 'Lumpy Skin Disease (LSD)',
      short: 'Viral disease causing skin nodules',
      symptoms:
          'Skin lumps, fever, decreased appetite, decreased milk, sometimes eye/nasal discharge',
      treatmentAtFarm:
          'Supportive care, isolate affected animals, control insect vectors, contact vet for specific care.',
      vetRequired: true,
      precautions:
          'Vector control, vaccination where available, isolate and report outbreaks.',
    ),
    _DiseaseItem(
      name: 'Parasitic Infestation (Ticks / Internal worms)',
      short: 'External and internal parasites affecting general health',
      symptoms:
          'Poor condition, anemia, itching (ticks), diarrhoea/weight loss (worms)',
      treatmentAtFarm:
          'Regular deworming schedule, topical tick control, maintain clean environment.',
      vetRequired: false,
      precautions:
          'Follow recommended deworming programs, pasture rotation, tick control measures.',
    ),
    _DiseaseItem(
      name: 'Brucellosis',
      short: 'Bacterial disease affecting reproduction',
      symptoms: 'Abortions, retained placenta, reduced fertility',
      treatmentAtFarm:
          'Not treatable on farm; infected animals often need veterinary assessment and herd testing.',
      vetRequired: true,
      precautions:
          'Practice safe handling, test-and-slaughter policies may apply, maintain biosecurity.',
    ),
  ];

  late List<_DiseaseItem> _filtered;

  @override
  void initState() {
    super.initState();
    _filtered = _allDiseases;
    _searchCtrl.addListener(_updateSearchQuery);
    _listAnimController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..forward();
  }

  void _updateSearchQuery() {
    setState(() {
      _query = _searchCtrl.text.trim();
      _filterDiseases();
      _listAnimController.forward(from: 0.0);
    });
  }

  void _filterDiseases() {
    final q = _query.toLowerCase();
    _filtered = _allDiseases.where((d) {
      final matchesSearch = q.isEmpty ||
          d.name.toLowerCase().contains(q) ||
          d.short.toLowerCase().contains(q) ||
          d.symptoms.toLowerCase().contains(q);
      final matchesFilter = _filter == 'All'
          ? true
          : _filter == 'Vet Required'
              ? d.vetRequired
              : !d.vetRequired;
      return matchesSearch && matchesFilter;
    }).toList();
  }

  void _openDetails(_DiseaseItem disease) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.tealAccent.shade200 : cs.primary;

    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      backgroundColor: cs.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.85,
        builder: (_, controller) => ListView(
          controller: controller,
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              disease.name,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(disease.short, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 24),
            _detailSection('Symptoms', disease.symptoms, Icons.sick, iconColor),
            _detailSection('Farm Treatment Plan', disease.treatmentAtFarm,
                Icons.healing_rounded, iconColor),
            _detailSection('Prevention & Biosecurity', disease.precautions,
                Icons.security_rounded, iconColor),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.bottomCenter,
              child: Chip(
                label: Text(
                  disease.vetRequired
                      ? 'Vet Required'
                      : 'Farm Curable (On-site)',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor:
                    disease.vetRequired ? Colors.redAccent : Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailSection(
      String title, String text, IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: iconColor.withOpacity(0.15),
              child: Icon(icon, size: 20, color: iconColor),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: iconColor,
              ),
            ),
          ]),
          const SizedBox(height: 8),
          Text(text, style: const TextStyle(fontSize: 15, height: 1.4)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
        child: Column(
          children: [
            SearchBar(
              controller: _searchCtrl,
              hintText: 'Search disease or symptom...',
              leading: const Icon(Icons.search),
              padding: const WidgetStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            const SizedBox(height: 16),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'All', label: Text('All')),
                ButtonSegment(value: 'Vet Required', label: Text('Vet')),
                ButtonSegment(value: 'On-site', label: Text('On-site')),
              ],
              selected: {_filter},
              onSelectionChanged: (s) {
                setState(() {
                  _filter = s.first;
                  _filterDiseases();
                  _listAnimController.forward(from: 0.0);
                });
              },
              style: SegmentedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                backgroundColor:
                    isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100,
                selectedBackgroundColor: isDark
                    ? Colors.tealAccent.withOpacity(0.25)
                    : cs.primaryContainer.withOpacity(0.4),
                selectedForegroundColor:
                    isDark ? Colors.tealAccent.shade200 : cs.primary,
                foregroundColor: isDark ? Colors.white70 : Colors.grey.shade800,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _filtered.length,
                itemBuilder: (context, index) {
                  final d = _filtered[index];
                  return FadeTransition(
                    opacity: Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: _listAnimController,
                        curve: Interval(index * 0.1, 1.0, curve: Curves.easeIn),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: Material(
                            color: cs.surface.withOpacity(0.9),
                            elevation: 2,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: CircleAvatar(
                                radius: 26,
                                backgroundColor: d.vetRequired
                                    ? Colors.redAccent.withOpacity(0.15)
                                    : Colors.green.withOpacity(0.15),
                                child: Icon(
                                  d.vetRequired
                                      ? Icons.local_hospital_rounded
                                      : Icons.healing_rounded,
                                  color: d.vetRequired
                                      ? Colors.redAccent
                                      : Colors.green,
                                ),
                              ),
                              title: Text(
                                d.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  d.short,
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                              onTap: () => _openDetails(d),
                            ),
                          ),
                        ),
                      ),
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
}
