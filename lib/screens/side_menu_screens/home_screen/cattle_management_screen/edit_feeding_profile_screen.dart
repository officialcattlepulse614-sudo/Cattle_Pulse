// screens/edit_feeding_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:cattle_pulse/screens/side_menu_screens/home_screen/cattle_management_screen/cattle_model.dart';
import 'package:cattle_pulse/screens/side_menu_screens/home_screen/cattle_management_screen/cattle_service.dart';

class EditFeedingProfileScreen extends StatefulWidget {
  final CattleModel cattle;

  const EditFeedingProfileScreen({super.key, required this.cattle});

  @override
  State<EditFeedingProfileScreen> createState() =>
      _EditFeedingProfileScreenState();
}

class _EditFeedingProfileScreenState extends State<EditFeedingProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final CattleService _cattleService = CattleService();

  late TextEditingController _totalFeedController;
  late TextEditingController _hayController;
  late TextEditingController _binolaController;
  late TextEditingController _chokarController;
  late TextEditingController _makaiController;
  late TextEditingController _waterController;

  String _selectedFeedType = "Dry Feed";
  final List<String> _feedTypes = ["Dry Feed", "Wet Feed", "Mixed Feed"];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final profile = widget.cattle.feederProfile;

    // Normalize feedType to match dropdown values
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

  Future<void> _saveFeedingProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final totalPercentage = _getTotalPercentage();
    if (totalPercentage != 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                  "Total percentage must equal 100% (currently $totalPercentage%)"),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final updatedProfile = AutoFeederProfile(
      feedType: _selectedFeedType,
      totalFeedKg: int.parse(_totalFeedController.text),
      hayPercent: int.parse(_hayController.text),
      binolaPercent: int.parse(_binolaController.text),
      chokarPercent: int.parse(_chokarController.text),
      makaiLeavesPercent: int.parse(_makaiController.text),
      waterPercent: int.parse(_waterController.text),
    );

    final success = await _cattleService.updateFeedingProfile(
      widget.cattle.id,
      updatedProfile,
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text("Feeding profile updated successfully!"),
              ],
            ),
            backgroundColor: const Color(0xFF4CAF50),
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(width: 8),
                Text("Failed to update feeding profile"),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final totalPercentage = _getTotalPercentage();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Feeding Profile"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cattle Info Header
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.pets,
                            color: colorScheme.primary, size: 32),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.cattle.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.cattle.tagId,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Feed Type Dropdown
              Text(
                "Feed Type",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _feedTypes.firstWhere(
                  (e) => e == _selectedFeedType,
                  orElse: () => _feedTypes.first,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.fastfood),
                  filled: true,
                  fillColor: isDark ? const Color(0xFF1F1B18) : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                items: _feedTypes
                    .map((type) =>
                        DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFeedType = value!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Total Feed
              _buildNumberField(
                controller: _totalFeedController,
                label: "Total Feed (Kg)",
                icon: Icons.scale,
                hint: "Enter total feed in kg",
              ),
              const SizedBox(height: 24),

              // Percentage Section
              Text(
                "Feed Composition (Total must equal 100%)",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: totalPercentage == 100
                      ? Colors.green.withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        totalPercentage == 100 ? Colors.green : Colors.orange,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      totalPercentage == 100
                          ? Icons.check_circle
                          : Icons.warning,
                      color:
                          totalPercentage == 100 ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Current Total: $totalPercentage%",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: totalPercentage == 100
                            ? Colors.green
                            : Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Percentage Fields
              _buildPercentageField(
                controller: _hayController,
                label: "Hay",
                color: const Color(0xFFFFD54F),
              ),
              const SizedBox(height: 12),
              _buildPercentageField(
                controller: _binolaController,
                label: "Binola",
                color: const Color(0xFFFF8A65),
              ),
              const SizedBox(height: 12),
              _buildPercentageField(
                controller: _chokarController,
                label: "Chokar",
                color: const Color(0xFF81C784),
              ),
              const SizedBox(height: 12),
              _buildPercentageField(
                controller: _makaiController,
                label: "Makai Leaves",
                color: const Color(0xFF64B5F6),
              ),
              const SizedBox(height: 12),
              _buildPercentageField(
                controller: _waterController,
                label: "Water",
                color: const Color(0xFF4FC3F7),
              ),
              const SizedBox(height: 32),

              // Save Button
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _saveFeedingProfile,
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Icon(Icons.check),
                label: Text(_isLoading ? "Saving..." : "Save Changes"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 54),
                  backgroundColor: colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              // Cancel Button
              OutlinedButton.icon(
                onPressed: _isLoading ? null : () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                label: const Text("Cancel"),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            filled: true,
            fillColor: isDark ? const Color(0xFF1F1B18) : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            if (int.tryParse(value) == null) {
              return 'Please enter a valid number';
            }
            if (int.parse(value) <= 0) {
              return 'Value must be greater than 0';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPercentageField({
    required TextEditingController controller,
    required String label,
    required Color color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: "Enter percentage",
            suffixText: "%",
            filled: true,
            fillColor: isDark ? const Color(0xFF1F1B18) : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            final intValue = int.tryParse(value);
            if (intValue == null) {
              return 'Invalid number';
            }
            if (intValue < 0 || intValue > 100) {
              return 'Must be 0-100';
            }
            return null;
          },
        ),
      ],
    );
  }
}
