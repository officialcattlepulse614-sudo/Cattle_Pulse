import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FilterColorConfig {
  // Selected Tile Colors
  static const Color tile_selected_background_dark = Color(0xFF2A2521);
  static const Color tile_selected_background_light =
      Color.fromARGB(255, 218, 204, 183);
  static const Color tile_unselected_background_dark = Color(0xFF36302B);
  static const Color tile_unselected_background_light =
      Color.fromARGB(255, 247, 233, 210);

  // Button Colors
  static const Color button_active_background_dark = Color(0xFFB87333);
  static const Color button_active_background_light = Color(0xFFE29B4B);
  static const Color button_inactive_background_dark = Color(0xFF36302B);
  static const Color button_inactive_background_light = Color(0xFFE6DAC6);

  // Chip Colors
  static const Color chip_vet_required = Colors.redAccent;
  static const Color chip_on_site = Colors.green;
  static const Color chip_all = Colors.green;

  static Color getChipColorByFilter(String filterName) {
    if (filterName == 'Vet Required') return chip_vet_required;
    if (filterName == 'On-site') return chip_on_site;
    return chip_all;
  }
}

class LocalDiagnosisTestApp extends StatelessWidget {
  const LocalDiagnosisTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farm Health Guide',
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: ThemeMode.system,
      home: const DiagnosisTreatmentScreen(),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF4CAF50),
      brightness: brightness,
      scaffoldBackgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFF9FAFB),
      cardColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
    );
  }
}

class Disease {
  final String name, short, symptoms, treatment, precautions;
  final bool vetRequired;

  const Disease(this.name, this.short, this.symptoms, this.treatment,
      this.precautions, this.vetRequired);
}

class DiagnosisTreatmentScreen extends StatefulWidget {
  const DiagnosisTreatmentScreen({super.key});

  @override
  State<DiagnosisTreatmentScreen> createState() =>
      _DiagnosisTreatmentScreenState();
}

class _DiagnosisTreatmentScreenState extends State<DiagnosisTreatmentScreen>
    with SingleTickerProviderStateMixin {
  final _searchCtrl = TextEditingController();
  String _query = '', _filter = 'All';
  late AnimationController _animCtrl;

  static const _diseases = [
    Disease(
        'Mastitis',
        'Udder infection — common after calving',
        'Swollen/hot udder, abnormal milk, fever, reduced yield',
        'Clean udder, frequent milking, apply warm compresses, consult vet for antibiotics.',
        'Maintain clean housing, proper milking hygiene, isolate affected animals.',
        true),
    Disease(
        'Foot-and-Mouth Disease (FMD)',
        'Highly contagious viral disease',
        'Fever, blisters on mouth/feet/teats, salivation, lameness, sudden drop in milk',
        'Isolate affected animals, supportive care (fluids, soft food), strict biosecurity.',
        'Control movement, disinfect pens, report to local animal health authorities.',
        true),
    Disease(
        'Bloat (Ruminal tympany)',
        'Gas accumulation in rumen — can be life threatening',
        'Swelling on left flank, discomfort, difficulty breathing',
        'Move animal to stand, pass an ororuminal tube if trained, give anti-foaming agents.',
        'Avoid sudden diet changes, limit access to lush legumes, feed slowly.',
        true),
    Disease(
        'Lumpy Skin Disease (LSD)',
        'Viral disease causing skin nodules',
        'Skin lumps, fever, decreased appetite, decreased milk, eye/nasal discharge',
        'Supportive care, isolate affected animals, insect control.',
        'Vector control, vaccination where available, isolate and report outbreaks.',
        true),
    Disease(
        'Parasitic Infestation (Ticks / Internal worms)',
        'Parasites affecting overall health',
        'Poor condition, anemia, itching (ticks), diarrhoea/weight loss (worms)',
        'Regular deworming, topical tick control, maintain clean environment.',
        'Pasture rotation, tick control measures.',
        false),
    Disease(
        'Brucellosis',
        'Bacterial disease affecting reproduction',
        'Abortions, retained placenta, reduced fertility',
        'Not treatable; requires veterinary assessment & herd testing.',
        'Safe handling, test animals, biosecurity.',
        true),
  ];

  List<Disease> get _filtered {
    final q = _query.toLowerCase();
    return _diseases.where((d) {
      final matchSearch = q.isEmpty ||
          d.name.toLowerCase().contains(q) ||
          d.short.toLowerCase().contains(q) ||
          d.symptoms.toLowerCase().contains(q);
      final matchFilter = _filter == 'All' ||
          (_filter == 'Vet Required' ? d.vetRequired : !d.vetRequired);
      return matchSearch && matchFilter;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() => setState(() {
          _query = _searchCtrl.text.trim();
          _animCtrl.forward(from: 0);
        }));
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..forward();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  Widget _buildFilterOption(String label, IconData icon, Color bgColor,
      Color iconColor, Color textColor) {
    final bool isSelected = _filter == label;
    final Color tileBgColor = isSelected
        ? (Theme.of(context).brightness == Brightness.dark
            ? FilterColorConfig.tile_selected_background_dark
            : FilterColorConfig.tile_selected_background_light)
        : (Theme.of(context).brightness == Brightness.dark
            ? FilterColorConfig.tile_unselected_background_dark
            : FilterColorConfig.tile_unselected_background_light);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: tileBgColor, borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(label,
            style: TextStyle(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: textColor)),
        trailing:
            isSelected ? Icon(Icons.check_circle, color: iconColor) : null,
        onTap: () {
          HapticFeedback.selectionClick();
          Navigator.pop(context);
          setState(() {
            _filter = label;
            _animCtrl.forward(from: 0);
          });
        },
      ),
    );
  }

  Widget _buildFilterButton(Color bgColor, Color iconColor) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          onTap: _showFilter,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.all(14),
            child: Icon(Icons.tune_rounded, color: iconColor, size: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveFilterChip() {
    final Color mainChipColor = FilterColorConfig.getChipColorByFilter(_filter);
    final Color chipBgColor = mainChipColor.withOpacity(0.1);
    final Color chipBorderColor = mainChipColor.withOpacity(0.3);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          color: chipBgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: chipBorderColor)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.filter_alt, size: 14, color: mainChipColor),
          const SizedBox(width: 4),
          Text('Filter: $_filter',
              style: TextStyle(
                  color: mainChipColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              setState(() {
                _filter = 'All';
                _animCtrl.forward(from: 0);
              });
            },
            child: Icon(Icons.close, size: 17, color: mainChipColor),
          ),
        ],
      ),
    );
  }

  void _showFilter() {
    HapticFeedback.lightImpact();
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor =
        isDark ? const Color(0xFF1F1B18) : const Color(0xFFE6DAC6);
    final Color iconColor =
        isDark ? const Color(0xFFE29B4B) : const Color(0xFFB87333);
    final Color textColor =
        isDark ? const Color(0xFFF5E6C8) : const Color(0xFF3B2E1A);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      backgroundColor: bgColor,
      builder: (ctx) => SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0x9DE29C4B)
                            : const Color(0x9BB87333),
                        borderRadius: BorderRadius.circular(40)),
                    child: Icon(Icons.tune_rounded, size: 26, color: bgColor),
                  ),
                  const SizedBox(width: 12),
                  Text('Filter Options',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              fontWeight: FontWeight.bold, color: textColor)),
                ],
              ),
              const SizedBox(height: 24),
              _buildFilterOption(
                  'All', Icons.list_rounded, bgColor, iconColor, textColor),
              _buildFilterOption('Vet Required', Icons.local_hospital_rounded,
                  bgColor, iconColor, textColor),
              _buildFilterOption('On-site', Icons.home_repair_service_rounded,
                  bgColor, iconColor, textColor),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetails(Disease d) {
    HapticFeedback.lightImpact();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor =
        isDark ? const Color(0xFF1F1B18) : const Color(0xFFE6DAC6);
    final Color iconColor =
        isDark ? const Color(0xFFFFB74D) : const Color(0xFFEF6C00);
    final Color textColor =
        isDark ? const Color(0xFFF5E6C8) : const Color(0xFF836232);
    final Color text2Color =
        isDark ? const Color(0xFFFFBA6A) : const Color(0xFF836232);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: bgColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        builder: (ctx, ctrl) => ListView(
          controller: ctrl,
          padding: const EdgeInsets.all(24),
          children: [
            Center(
                child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFFE29B4B)
                            : const Color(0xFFB87333),
                        borderRadius: BorderRadius.circular(2)))),
            Text(d.name,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? const Color(0xFFF5E6C8)
                        : const Color(0xFF3B2E1A))),
            const SizedBox(height: 10),
            Text(d.short,
                style: TextStyle(
                    color: isDark
                        ? const Color(0xFFFFBA6A)
                        : const Color(0xFF836232),
                    fontSize: 16)),
            const SizedBox(height: 24),
            _detailSection('Symptoms', d.symptoms, Icons.sick, iconColor,
                textColor, text2Color),
            _detailSection('Farm Treatment Plan', d.treatment,
                Icons.healing_rounded, iconColor, textColor, text2Color),
            _detailSection('Prevention & Biosecurity', d.precautions,
                Icons.security_rounded, iconColor, textColor, text2Color),
            const SizedBox(height: 20),
            _badge(d.vetRequired),
          ],
        ),
      ),
    );
  }

  Widget _detailSection(String title, String text, IconData icon,
          Color iconColor, Color textColor, Color text2Color) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(icon, size: 22, color: iconColor)),
              const SizedBox(width: 12),
              Expanded(
                  child: Text(title,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          color: textColor))),
            ]),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: text2Color,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _badge(bool vetRequired) => Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          color: vetRequired ? Colors.redAccent : Colors.green,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: (vetRequired ? Colors.redAccent : Colors.green)
                    .withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4))
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(vetRequired ? Icons.local_hospital : Icons.check_circle,
                color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(vetRequired ? 'Veterinary Care Required' : 'Farm Manageable',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15)),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final diseases = _filtered;

    // Theme variables
    final Color bgColor =
        isDark ? const Color(0xFF1F1B18) : const Color(0xFFE6DAC6);
    final Color iconColor =
        isDark ? const Color(0xFFE29B4B) : const Color(0xFFB87333);
    final Color textColor =
        isDark ? const Color(0xFFF5E6C8) : const Color(0xFF3B2E1A);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                children: [
                  Row(children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                              color: bgColor.withOpacity(0.25),
                              blurRadius: 8,
                              offset: const Offset(0, 4))
                        ],
                      ),
                      child: Icon(Icons.favorite_border,
                          color: iconColor, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Farm Health Guide',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: -0.5,
                                      color: textColor)),
                          Text('${diseases.length} diseases available',
                              style: TextStyle(
                                  color: isDark
                                      ? const Color(0xB5F5E6C8)
                                      : const Color(0xB33B2E1A),
                                  fontSize: 13)),
                        ],
                      ),
                    ),
                  ]),
                  const SizedBox(height: 20),
                  Row(children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: TextField(
                          controller: _searchCtrl,
                          style: TextStyle(
                              color: isDark
                                  ? const Color(0xFFE6DAC6)
                                  : Colors.black87),
                          decoration: InputDecoration(
                            hintText: 'Search diseases, symptoms...',
                            hintStyle: TextStyle(color: textColor),
                            prefixIcon:
                                Icon(Icons.search_rounded, color: iconColor),
                            suffixIcon: _query.isNotEmpty
                                ? IconButton(
                                    icon: Icon(Icons.clear_rounded,
                                        color: iconColor),
                                    onPressed: () {
                                      HapticFeedback.lightImpact();
                                      _searchCtrl.clear();
                                    })
                                : null,
                            filled: false,
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    _buildFilterButton(bgColor, iconColor),
                  ]),
                  if (_filter != 'All') ...[
                    const SizedBox(height: 12),
                    _buildActiveFilterChip(),
                  ],
                ],
              ),
            ),
            Expanded(
              child: diseases.isEmpty
                  ? Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Icon(Icons.search_off_rounded,
                              size: 64,
                              color: isDark
                                  ? const Color.fromARGB(164, 226, 156, 75)
                                  : const Color.fromARGB(172, 184, 115, 51)),
                          const SizedBox(height: 16),
                          Text('No diseases found',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: textColor)),
                          const SizedBox(height: 8),
                          Text('Try adjusting your search or filter',
                              style: TextStyle(fontSize: 14, color: textColor)),
                        ]))
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                      itemCount: diseases.length,
                      itemBuilder: (_, i) => FadeTransition(
                        opacity: Tween(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                                parent: _animCtrl,
                                curve: Interval((i * 0.06).clamp(0.0, 1.0), 1.0,
                                    curve: Curves.easeOut))),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => _showDetails(diseases[i]),
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: bgColor),
                                  boxShadow: [
                                    BoxShadow(
                                        color: isDark
                                            ? Colors.black.withOpacity(0.35)
                                            : Colors.black.withOpacity(0.04),
                                        blurRadius: 10,
                                        offset: const Offset(0, 2))
                                  ],
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Row(children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: diseases[i].vetRequired
                                            ? Colors.redAccent.withOpacity(0.12)
                                            : Colors.green.withOpacity(0.12),
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    child: Icon(
                                        diseases[i].vetRequired
                                            ? Icons.local_hospital_rounded
                                            : Icons.healing_rounded,
                                        color: diseases[i].vetRequired
                                            ? Colors.redAccent
                                            : Colors.green,
                                        size: 24),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(diseases[i].name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: textColor)),
                                        const SizedBox(height: 4),
                                        Text(diseases[i].short,
                                            style: TextStyle(
                                                color: isDark
                                                    ? const Color.fromARGB(
                                                        190, 245, 230, 200)
                                                    : const Color.fromARGB(
                                                        153, 59, 46, 26),
                                                fontSize: 13),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis),
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios_rounded,
                                      size: 16,
                                      color: isDark
                                          ? Colors.white38
                                          : Colors.black26),
                                ]),
                              ),
                            ),
                          ),
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
