// screens/edit_cattle_screen.dart
import 'package:flutter/material.dart';
import 'package:cattle_pulse/screens/side_menu_screens/home_screen/cattle_management_screen/cattle_model.dart';
import 'package:cattle_pulse/screens/side_menu_screens/home_screen/cattle_management_screen/cattle_service.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:share_plus/share_plus.dart';

class EditCattleScreen extends StatefulWidget {
  final CattleModel cattle;

  const EditCattleScreen({super.key, required this.cattle});

  @override
  State<EditCattleScreen> createState() => _EditCattleScreenState();
}

class _EditCattleScreenState extends State<EditCattleScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final CattleService _cattleService = CattleService();

  // Cattle Details Controllers
  late TextEditingController _nameController;
  late TextEditingController _tagIdController;
  late TextEditingController _breedController;
  late TextEditingController _ageController;
  late TextEditingController _weightController;

  // Feeding Profile Controllers
  late TextEditingController _totalFeedController;
  late TextEditingController _hayController;
  late TextEditingController _binolaController;
  late TextEditingController _chokarController;
  late TextEditingController _makaiController;
  late TextEditingController _waterController;

  String _selectedHealthStatus = "Healthy";
  String _selectedFeedType = "Dry Feed";

  final List<String> _healthStatuses = [
    "Healthy",
    "Sick",
    "Under Treatment",
    "Recovering"
  ];
  final List<String> _feedTypes = ["Dry Feed", "Wet Feed", "Mixed Feed"];

  late TabController _tabController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Initialize Cattle Details
    _nameController = TextEditingController(text: widget.cattle.name);
    _tagIdController = TextEditingController(text: widget.cattle.tagId);
    _breedController = TextEditingController(text: widget.cattle.breed);
    _ageController =
        TextEditingController(text: widget.cattle.ageMonths.toString());
    _weightController =
        TextEditingController(text: widget.cattle.weightKg.toString());
    _selectedHealthStatus = widget.cattle.healthStatus;

    // Initialize Feeding Profile
    final profile = widget.cattle.feederProfile;
    final feedTypeMap = {
      "dry": "Dry Feed",
      "wet": "Wet Feed",
      "mixed": "Mixed Feed",
    };
    _selectedFeedType =
        feedTypeMap[profile.feedType.toLowerCase()] ?? "Dry Feed";
    _totalFeedController =
        TextEditingController(text: profile.totalFeedKg.toString());
    _hayController = TextEditingController(text: profile.hayPercent.toString());
    _binolaController =
        TextEditingController(text: profile.binolaPercent.toString());
    _chokarController =
        TextEditingController(text: profile.chokarPercent.toString());
    _makaiController =
        TextEditingController(text: profile.makaiLeavesPercent.toString());
    _waterController =
        TextEditingController(text: profile.waterPercent.toString());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _tagIdController.dispose();
    _breedController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _totalFeedController.dispose();
    _hayController.dispose();
    _binolaController.dispose();
    _chokarController.dispose();
    _makaiController.dispose();
    _waterController.dispose();
    super.dispose();
  }

  int _getTotalPercentage() {
    return (int.tryParse(_hayController.text) ?? 0) +
        (int.tryParse(_binolaController.text) ?? 0) +
        (int.tryParse(_chokarController.text) ?? 0) +
        (int.tryParse(_makaiController.text) ?? 0) +
        (int.tryParse(_waterController.text) ?? 0);
  }

  void _shareCattleInfo() {
    final shareText = '''
🐄 Cattle Information - ${_nameController.text}

📋 Basic Details:
• Tag ID: ${_tagIdController.text}
• Breed: ${_breedController.text}
• Age: ${_ageController.text} months
• Weight: ${_weightController.text} kg
• Health Status: $_selectedHealthStatus

🌾 Feeding Profile:
• Feed Type: $_selectedFeedType
• Total Feed: ${_totalFeedController.text} kg/day
• Hay: ${_hayController.text}%
• Binola: ${_binolaController.text}%
• Chokar: ${_chokarController.text}%
• Makai Leaves: ${_makaiController.text}%
• Water: ${_waterController.text}%

Generated from Cattle Pulse App
    ''';

    Share.share(shareText);
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate feeding profile percentages
    final totalPercentage = _getTotalPercentage();
    if (totalPercentage != 100) {
      _showSnackBar(
        "Total percentage must equal 100% (currently $totalPercentage%)",
        isError: true,
      );
      _tabController.animateTo(1); // Switch to feeding profile tab
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Update cattle details
      final cattleUpdates = {
        'name': _nameController.text.trim(),
        'tagId': _tagIdController.text.trim(),
        'breed': _breedController.text.trim(),
        'ageMonths': int.parse(_ageController.text),
        'weightKg': int.parse(_weightController.text),
        'healthStatus': _selectedHealthStatus,
      };

      final cattleSuccess = await _cattleService.updateCattle(
        widget.cattle.id,
        cattleUpdates,
      );

      // Update feeding profile
      final updatedProfile = AutoFeederProfile(
        feedType: _selectedFeedType,
        totalFeedKg: int.parse(_totalFeedController.text),
        hayPercent: int.parse(_hayController.text),
        binolaPercent: int.parse(_binolaController.text),
        chokarPercent: int.parse(_chokarController.text),
        makaiLeavesPercent: int.parse(_makaiController.text),
        waterPercent: int.parse(_waterController.text),
      );

      final profileSuccess = await _cattleService.updateFeedingProfile(
        widget.cattle.id,
        updatedProfile,
      );

      setState(() => _isLoading = false);

      if (cattleSuccess && profileSuccess) {
        _showSnackBar("Cattle information updated successfully!",
            isError: false);
        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) Navigator.pop(context, true);
      } else {
        _showSnackBar("Failed to update cattle information", isError: true);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar("Error: ${e.toString()}", isError: true);
    }
  }

  void _showSnackBar(String message, {required bool isError}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? LucideIcons.alertCircle : LucideIcons.checkCircle2,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor:
            isError ? const Color(0xFFE53935) : const Color(0xFF4CAF50),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isDark ? colorScheme.surface : theme.cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: theme.iconTheme.color,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Edit Cattle",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _shareCattleInfo,
                    icon: Icon(
                      LucideIcons.share2,
                      color: theme.iconTheme.color,
                    ),
                  ),
                ],
              ),
            ),

            // Tab Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isDark ? colorScheme.surface : theme.cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                labelColor: isDark ? colorScheme.onPrimary : Colors.white,
                unselectedLabelColor: colorScheme.onSurface.withOpacity(0.6),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
                tabs: const [
                  Tab(text: "Cattle Details"),
                  Tab(text: "Feeding Profile"),
                ],
              ),
            ),

            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildCattleDetailsTab(isDark, colorScheme),
                  _buildFeedingProfileTab(isDark, colorScheme),
                ],
              ),
            ),

            // Save Button
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? colorScheme.surface : theme.cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor:
                        isDark ? colorScheme.onPrimary : Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isDark ? colorScheme.onPrimary : Colors.white,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              LucideIcons.save,
                              size: 20,
                              color:
                                  isDark ? colorScheme.onPrimary : Colors.white,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Save All Changes",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: isDark
                                    ? colorScheme.onPrimary
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCattleDetailsTab(bool isDark, ColorScheme colorScheme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              controller: _nameController,
              label: "Cattle Name",
              icon: LucideIcons.tag,
              hint: "Enter cattle name",
              isDark: isDark,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _tagIdController,
              label: "Tag ID",
              icon: LucideIcons.hash,
              hint: "Enter tag ID",
              isDark: isDark,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _breedController,
              label: "Breed",
              icon: LucideIcons.dna,
              hint: "Enter breed",
              isDark: isDark,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _ageController,
              label: "Age (Months)",
              icon: LucideIcons.calendar,
              hint: "Enter age in months",
              isDark: isDark,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _weightController,
              label: "Weight (Kg)",
              icon: LucideIcons.scale,
              hint: "Enter weight in kg",
              isDark: isDark,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: "Health Status",
              icon: LucideIcons.heartPulse,
              value: _selectedHealthStatus,
              items: _healthStatuses,
              onChanged: (value) {
                setState(() => _selectedHealthStatus = value!);
              },
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedingProfileTab(bool isDark, ColorScheme colorScheme) {
    final totalPercentage = _getTotalPercentage();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDropdown(
            label: "Feed Type",
            icon: LucideIcons.wheat,
            value: _selectedFeedType,
            items: _feedTypes,
            onChanged: (value) {
              setState(() => _selectedFeedType = value!);
            },
            isDark: isDark,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _totalFeedController,
            label: "Total Feed (Kg/Day)",
            icon: Icons.scale,
            hint: "Enter total feed",
            isDark: isDark,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),

          // Percentage Section Header
          Text(
            "Feed Composition",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),

          // Total Percentage Indicator
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: totalPercentage == 100
                  ? const Color(0xFF4CAF50).withOpacity(0.1)
                  : const Color(0xFFFF9800).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: totalPercentage == 100
                    ? const Color(0xFF4CAF50)
                    : const Color(0xFFFF9800),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  totalPercentage == 100
                      ? LucideIcons.checkCircle2
                      : LucideIcons.alertCircle,
                  color: totalPercentage == 100
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFFFF9800),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total: $totalPercentage%",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: totalPercentage == 100
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFFFF9800),
                        ),
                      ),
                      Text(
                        totalPercentage == 100
                            ? "Perfect! All percentages add up correctly"
                            : "Must equal 100%",
                        style: TextStyle(
                          fontSize: 12,
                          color: (totalPercentage == 100
                                  ? const Color(0xFF4CAF50)
                                  : const Color(0xFFFF9800))
                              .withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Percentage Fields
          _buildPercentageField(
            controller: _hayController,
            label: "Hay",
            color: const Color(0xFFFFD54F),
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          _buildPercentageField(
            controller: _binolaController,
            label: "Binola",
            color: const Color(0xFFFF8A65),
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          _buildPercentageField(
            controller: _chokarController,
            label: "Chokar",
            color: const Color(0xFF81C784),
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          _buildPercentageField(
            controller: _makaiController,
            label: "Makai Leaves",
            color: const Color(0xFF64B5F6),
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          _buildPercentageField(
            controller: _waterController,
            label: "Water",
            color: const Color(0xFF4FC3F7),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    required bool isDark,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(color: colorScheme.onSurface),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: colorScheme.onSurface.withOpacity(0.4),
            ),
            prefixIcon: Icon(icon, color: theme.iconTheme.color),
            filled: true,
            fillColor: isDark ? colorScheme.surface : theme.cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: colorScheme.onSurface.withOpacity(0.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 2,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            if (keyboardType == TextInputType.number) {
              if (int.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              if (int.parse(value) <= 0) {
                return 'Value must be greater than 0';
              }
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
    required bool isDark,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
        ),
        DropdownButtonFormField<String>(
          initialValue: value,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: theme.iconTheme.color),
            filled: true,
            fillColor: isDark ? colorScheme.surface : theme.cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: colorScheme.onSurface.withOpacity(0.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 2,
              ),
            ),
          ),
          dropdownColor: isDark ? colorScheme.surface : theme.cardColor,
          style: TextStyle(color: colorScheme.onSurface),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildPercentageField({
    required TextEditingController controller,
    required String label,
    required Color color,
    required bool isDark,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          onChanged: (_) => setState(() {}),
          style: TextStyle(color: colorScheme.onSurface),
          decoration: InputDecoration(
            hintText: "Enter percentage",
            hintStyle: TextStyle(
              color: colorScheme.onSurface.withOpacity(0.4),
            ),
            suffixText: "%",
            suffixStyle: TextStyle(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
            filled: true,
            fillColor: isDark ? colorScheme.surface : theme.cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: colorScheme.onSurface.withOpacity(0.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: color,
                width: 2,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            final intValue = int.tryParse(value);
            if (intValue == null) {
              return 'Invalid';
            }
            if (intValue < 0 || intValue > 100) {
              return '0-100';
            }
            return null;
          },
        ),
      ],
    );
  }
}
