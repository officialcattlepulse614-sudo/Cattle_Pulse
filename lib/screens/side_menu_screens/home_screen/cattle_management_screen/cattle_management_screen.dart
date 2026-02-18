import 'package:cattle_pulse/screens/side_menu_screens/home_screen/cattle_management_screen/delete_cattle.dart';
import 'package:flutter/material.dart';
import 'package:cattle_pulse/screens/side_menu_screens/home_screen/cattle_management_screen/cattle_model.dart';
import 'package:cattle_pulse/screens/side_menu_screens/home_screen/cattle_management_screen/cattle_service.dart';
import 'package:cattle_pulse/screens/side_menu_screens/home_screen/cattle_management_screen/cattle_profile_screen.dart';
import 'package:cattle_pulse/screens/side_menu_screens/home_screen/cattle_management_screen/add_cattle_screen.dart';
import 'package:cattle_pulse/screens/side_menu_screens/home_screen/cattle_management_screen/edit_cattle_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CattleManagementScreen extends StatefulWidget {
  const CattleManagementScreen({super.key});

  @override
  State<CattleManagementScreen> createState() => _CattleManagementScreenState();
}

class _CattleManagementScreenState extends State<CattleManagementScreen> {
  final CattleService _cattleService = CattleService();
  String filterStatus = "All";
  final TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  Color _getHealthStatusColor(String status, bool isDark) {
    switch (status) {
      case "Healthy":
        return isDark ? const Color(0xFF4CAF50) : const Color(0xFF2E7D32);
      case "Sick":
        return isDark ? const Color(0xFFF44336) : const Color(0xFFC62828);
      case "Under Treatment":
        return isDark ? const Color(0xFFFF9800) : const Color(0xFFE65100);
      default:
        return Colors.grey;
    }
  }

  IconData _getHealthStatusIcon(String status) {
    switch (status) {
      case "Healthy":
        return Icons.check_circle;
      case "Sick":
        return Icons.warning;
      case "Under Treatment":
        return Icons.medical_services;
      default:
        return Icons.help;
    }
  }

  List<CattleModel> _filterCattle(List<CattleModel> cattle) {
    return cattle.where((cow) {
      final matchesSearch = searchQuery.isEmpty ||
          cow.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          cow.tagId.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesHealth =
          filterStatus == "All" || cow.healthStatus == filterStatus;
      return matchesSearch && matchesHealth;
    }).toList();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _FilterBottomSheet(
        currentFilter: filterStatus,
        onFilterChanged: (newFilter) {
          setState(() {
            filterStatus = newFilter;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final containerPadding = screenWidth < 600 ? 10.0 : 14.0;
    final horizontalPadding =
        screenWidth < 600 ? 10.0 : 24.0; // smaller on mobile
    final verticalPadding = screenWidth < 600 ? 11.0 : 14.0;
    final iconSize = screenWidth < 600 ? 20.0 : 22.0;
    final headericonSize = screenWidth < 600 ? 22.0 : 26.0;
    final minFontSize = 12.0;
    final maxFontSize = screenWidth < 600 ? 16.0 : 18.0;

    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // HEADER + SEARCH + FILTER
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(containerPadding),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1F1B18)
                                : const Color(0xFFE6DAC6),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFF302518) //Dark Mode
                                  : const Color(0xFFA89B85), //Light Mode
                              width: 1.8,
                            ),
                          ),
                          child: Icon(
                            Icons.pets,
                            color: isDark
                                ? const Color(0xFFE29B4B)
                                : const Color(0xFFB87333),
                            size: headericonSize,
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "Manage Farm Cattles",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? const Color(0xFFF5E6C8)
                                        : const Color(0xFF2C2416),
                                    letterSpacing: -0.5,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              StreamBuilder<List<CattleModel>>(
                                stream: _cattleService.getCattleStream(),
                                builder: (context, snapshot) {
                                  final count = snapshot.hasData
                                      ? _filterCattle(snapshot.data!).length
                                      : 0;
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? const Color(0xFF3D362F)
                                          : const Color(0xFFE8DCC8),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "$count Animals",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: isDark
                                            ? const Color(
                                                0xFFF5E6C8) //Dark Mode
                                            : const Color(
                                                0xFF3B2E1A), //Light Mode
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1F1B18)
                                : const Color(0xFFE6DAC6),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFF302518) //Dark Mode
                                  : const Color(0xFFA89B85), //Light Mode
                              width: 1.8,
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const AddCattleScreen()),
                              ),
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPadding,
                                  vertical: verticalPadding,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: isDark
                                          ? const Color(0xFFE29B4B)
                                          : const Color(0xFFB87333),
                                      size: iconSize,
                                    ),
                                    SizedBox(width: screenWidth < 600 ? 6 : 8),
                                    AutoSizeText(
                                      "Add",
                                      style: TextStyle(
                                        color: isDark
                                            ? const Color(0xFFF5E6C8)
                                            : const Color(0xFF3B2E1A),
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      minFontSize: minFontSize,
                                      maxFontSize: maxFontSize,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // MODERN SEARCH BAR WITH FILTER
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF1F1B18) // Dark Mode
                                  : const Color(0xFFE6DAC6), // Light Mode
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: isDark
                                    ? const Color(0xFF302518) //Dark Mode
                                    : const Color(0xFFA89B85), //Light Mode
                                width: 1.8,
                              ),
                            ),
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) {
                                setState(() {
                                  searchQuery = value;
                                });
                              },
                              style: TextStyle(
                                fontSize: 15,
                                color: isDark
                                    ? const Color(0xFFF5E6C8)
                                    : const Color(0xFF2C2416),
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: isDark
                                    ? const Color(0xFF1F1B18) // Dark Mode
                                    : const Color(0xFFE6DAC6), // Light Mode
                                hintText: "Search by name or tag ID",
                                hintStyle: TextStyle(
                                  color: isDark
                                      ? const Color(0xFFF5E6C8)
                                      : const Color(0xFF3B2E1A),
                                  fontSize: 15,
                                ),
                                prefixIcon: Icon(
                                  Icons.search_rounded,
                                  color: isDark
                                      ? const Color(0xFFE29B4B)
                                      : const Color(0xFFB87333),
                                  size: 24,
                                ),
                                suffixIcon: searchQuery.isNotEmpty
                                    ? IconButton(
                                        icon: Icon(
                                          Icons.clear_rounded,
                                          color: isDark
                                              ? const Color(0xFFE29B4B)
                                              : const Color(0xFFB87333),
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          searchController.clear();
                                          setState(() {
                                            searchQuery = "";
                                          });
                                        },
                                      )
                                    : null,
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1F1B18)
                                : const Color(0xFFE6DAC6),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFF302518) //Dark Mode
                                  : const Color(0xFFA89B85), //Light Mode
                              width: 1.8,
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              onTap: _showFilterBottomSheet,
                              borderRadius: BorderRadius.circular(30),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    14), // SAME as your working code
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      Icons.tune_rounded,
                                      color: filterStatus != "All"
                                          ? Colors.white
                                          : (isDark
                                              ? const Color(0xFFE29B4B)
                                              : const Color(0xFFB87333)),
                                      size: 24, // SAME size as working code
                                    ),
                                    if (filterStatus != "All")
                                      Positioned(
                                        right: -4,
                                        top: -4,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: isDark
                                                ? const Color(0xFF4CAF50)
                                                : const Color(0xFF2E7D32),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // CATTLE LIST
                Expanded(
                  child: StreamBuilder<List<CattleModel>>(
                    stream: _cattleService.getCattleStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: isDark
                                    ? const Color(0xFFE29B4B)
                                    : const Color(0xFFB87333),
                                strokeWidth: 3,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Loading cattle data...",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: isDark
                                      ? const Color(0xFFF5E6C8) //Dark Mode
                                      : const Color(0xFF3B2E1A), //Light Mode,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.error_outline_rounded,
                                  size: 64,
                                  color: Colors.red[400],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Unable to Load Data',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? const Color(0xFFF5E6C8)
                                      : const Color(0xFF2C2416),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Text(
                                  '${snapshot.error}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isDark
                                        ? const Color(0xFFF5E6C8) //Dark Mode
                                        : const Color(0xFF3B2E1A), //Light Mode
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {});
                                },
                                icon: const Icon(Icons.refresh_rounded),
                                label: const Text('Try Again'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 14),
                                  backgroundColor: isDark
                                      ? const Color(0xFFE29B4B)
                                      : const Color(0xFFB87333),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      final allCattle = snapshot.data ?? [];

                      if (allCattle.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF1F1B18)
                                      : const Color(0xFFF5EDE0),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.pets,
                                  size: 80,
                                  color: isDark
                                      ? const Color(0xFF6B5F51)
                                      : const Color(0xFFB8A68E),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                "No Cattle Added Yet",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? const Color(0xFFF5E6C8)
                                      : const Color(0xFF2C2416),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Start by adding your first animal",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: isDark
                                      ? const Color(0x9EF5E6C8)
                                      : const Color(0x8D2C2416),
                                ),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton.icon(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const AddCattleScreen()),
                                ),
                                icon: const Icon(Icons.add),
                                label: const Text("Add Cattle"),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 14),
                                  backgroundColor: isDark
                                      ? const Color(0xFFE29B4B)
                                      : const Color(0xFFB87333),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      final filteredList = _filterCattle(allCattle);

                      if (filteredList.isEmpty) {
                        return Flexible(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).viewInsets.bottom + 20,
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight:
                                    MediaQuery.of(context).size.height * 0.4,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.search_off_rounded,
                                      size: 80,
                                      color: isDark
                                          ? const Color(0xA3E29C4B)
                                          : const Color(0xACB87333)),
                                  const SizedBox(height: 24),
                                  Text(
                                    "No Results Found",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: isDark
                                          ? const Color(0xFFF5E6C8)
                                          : const Color(0xFF3B2E1A),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Try adjusting your search or filters",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: isDark
                                          ? const Color(0xFFF5E6C8)
                                          : const Color(0xFF3B2E1A),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  OutlinedButton.icon(
                                    onPressed: () {
                                      searchController.clear();
                                      setState(() {
                                        searchQuery = "";
                                        filterStatus = "All";
                                      });
                                    },
                                    icon: const Icon(Icons.clear_all_rounded),
                                    label: const Text("Clear Filters"),
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32, vertical: 14),
                                      side: BorderSide(
                                        color: isDark
                                            ? const Color(0xFFE29B4B)
                                            : const Color(0xFFB87333),
                                        width: 2,
                                      ),
                                      foregroundColor: isDark
                                          ? const Color(0xFFE29B4B)
                                          : const Color(0xFFB87333),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final cow = filteredList[index];
                          final healthColor =
                              _getHealthStatusColor(cow.healthStatus, isDark);
                          final healthIcon =
                              _getHealthStatusIcon(cow.healthStatus);

                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF1F1B18) //Dark Mode
                                  : const Color(0xFFE6DAC6), //Light Mode

                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: isDark
                                    ? const Color(0xFF302518) //Dark Mode
                                    : const Color(0xFFA89B85), //Light Mode
                                width: 1.8,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          CattleProfileScreen(cow: cow)),
                                ),
                                borderRadius: BorderRadius.circular(20),
                                child: Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Top Row: Icon + Name + Tag + Health
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: isDark
                                                  ? const Color(
                                                      0xFF2A2520) //Dark Mode
                                                  : const Color(
                                                      0xFFF7EDDD), //Light Mode

                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                            child: Icon(
                                              Icons.pets,
                                              color: isDark
                                                  ? const Color(0xFFE29B4B)
                                                  : const Color(0xFFB87333),
                                              size: 28,
                                            ),
                                          ),

                                          const SizedBox(width: 14),
                                          // Expanded for Name + Tag
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AutoSizeText(
                                                  cow.name,
                                                  style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                    color: isDark
                                                        ? const Color(
                                                            0xFFF5E6C8)
                                                        : const Color(
                                                            0xFF2C2416),
                                                    letterSpacing: -0.3,
                                                  ),
                                                  maxLines: 1,
                                                  minFontSize: 12,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 6),
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 8,
                                                                vertical: 4),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: isDark
                                                              ? const Color(
                                                                  0xFF2A2420)
                                                              : const Color(
                                                                  0xFFF7EDDD),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .qr_code_2_rounded,
                                                              size: 14,
                                                              color: isDark
                                                                  ? const Color(
                                                                      0xFFE29B4B)
                                                                  : const Color(
                                                                      0xFFB87333),
                                                            ),
                                                            const SizedBox(
                                                                width: 4),
                                                            Flexible(
                                                              child:
                                                                  AutoSizeText(
                                                                cow.tagId,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: isDark
                                                                      ? const Color(
                                                                          0xFFF5E6C8)
                                                                      : const Color(
                                                                          0xFF2C2416),
                                                                ),
                                                                maxLines: 1,
                                                                minFontSize: 10,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          // Health Status
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                            decoration: BoxDecoration(
                                              color:
                                                  healthColor.withOpacity(0.12),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: healthColor
                                                    .withOpacity(0.3),
                                                width: 1.5,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(healthIcon,
                                                    size: 18,
                                                    color: healthColor),
                                                const SizedBox(width: 6),
                                                ConstrainedBox(
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxWidth: 100),
                                                  child: AutoSizeText(
                                                    cow.healthStatus,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: healthColor,
                                                    ),
                                                    maxLines: 1,
                                                    minFontSize: 10,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 18),
                                      // Chips Row
                                      Row(
                                        children: [
                                          Expanded(
                                              child: _ModernInfoChip(
                                                  icon: Icons.category_rounded,
                                                  label: cow.breed,
                                                  isDark: isDark)),
                                          const SizedBox(width: 10),
                                          Expanded(
                                              child: _ModernInfoChip(
                                                  icon: Icons.cake_rounded,
                                                  label: "${cow.ageMonths} mo",
                                                  isDark: isDark)),
                                          const SizedBox(width: 10),
                                          Expanded(
                                              child: _ModernInfoChip(
                                                  icon: Icons
                                                      .monitor_weight_rounded,
                                                  label: "${cow.weightKg} kg",
                                                  isDark: isDark)),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      // Action Buttons Row
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: isDark
                                                    ? const Color(0xFFE29B4B)
                                                    : const Color(0xFFD4956F),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            CattleProfileScreen(
                                                                cow: cow)),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 14),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .visibility_rounded,
                                                            size: 20,
                                                            color: isDark
                                                                ? Color(
                                                                    0xFF784212) //Dark
                                                                : Color(
                                                                    0xFF814633) //Light
                                                            ),
                                                        SizedBox(width: 8),
                                                        Text(
                                                          "View Profile",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: isDark
                                                                  ? Color(
                                                                      0xFF3E270F) //Dark
                                                                  : Color(
                                                                      0xFF401E14) //Light
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: isDark
                                                  ? const Color(0xFF2A2420)
                                                  : const Color(0xFFF0EBE3),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: isDark
                                                      ? const Color(0xFF3D362F)
                                                      : const Color(0xFFE8DCC8),
                                                  width: 1.5),
                                            ),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditCattleScreen(
                                                                cattle: cow)),
                                                  );
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(14),
                                                  child: Icon(
                                                      Icons.edit_rounded,
                                                      size: 22,
                                                      color: isDark
                                                          ? const Color(
                                                              0xFFE29B4B)
                                                          : const Color(
                                                              0xFFB87333)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: isDark
                                                  ? const Color(0xFF2A2420)
                                                  : const Color(0xFFF0EBE3),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: isDark
                                                    ? const Color(0xFF3D362F)
                                                    : const Color(0xFFE8DCC8),
                                                width: 1.5,
                                              ),
                                            ),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                onTap: () async {
                                                  await showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (_) =>
                                                        DeleteCattleDialog(
                                                            cattle: cow),
                                                  );
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsets.all(14),
                                                  child: Icon(
                                                    Icons.delete_rounded,
                                                    size: 22,
                                                    color: Color(0xFFD32F2F),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            )));
  }
}

// MODERN INFO CHIP
class _ModernInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;

  const _ModernInfoChip({
    required this.icon,
    required this.label,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2420) : const Color(0xFFF5EDE0),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark ? const Color(0xFF3D362F) : const Color(0xFFE8DCC8),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 16,
            color: isDark ? const Color(0xFF9C8B75) : const Color(0xFF6B5F51),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color:
                    isDark ? const Color(0xFFD4C4A8) : const Color(0xFF4A3F2E),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// FILTER BOTTOM SHEET
class _FilterBottomSheet extends StatefulWidget {
  final String currentFilter;
  final Function(String) onFilterChanged;

  const _FilterBottomSheet({
    required this.currentFilter,
    required this.onFilterChanged,
  });

  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = widget.currentFilter;
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1F1B18) //Dark Mode
            : const Color(0xFFE6DAC6), //Light Mode
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF3D362F) : const Color(0xFFE8DCC8),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isDark
                          ? [
                              const Color(0xFFE29B4B).withOpacity(0.2),
                              const Color(0xFFD67D2E).withOpacity(0.2),
                            ]
                          : [
                              const Color(0xFFD4956F).withOpacity(0.15),
                              const Color(0xFFB87333).withOpacity(0.15),
                            ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.tune_rounded,
                    color: isDark
                        ? const Color(0xFFE29B4B)
                        : const Color(0xFFB87333),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Filter by Health Status",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? const Color(0xFFF5E6C8)
                        : const Color(0xFF2C2416),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ...["All", "Healthy", "Sick", "Under Treatment"].map((status) {
            final isSelected = selectedFilter == status;
            IconData icon;
            Color statusColor;

            if (status == "All") {
              icon = Icons.grid_view_rounded;
              statusColor =
                  isDark ? const Color(0xFFE29B4B) : const Color(0xFFB87333);
            } else if (status == "Healthy") {
              icon = Icons.check_circle_rounded;
              statusColor =
                  isDark ? const Color(0xFF4CAF50) : const Color(0xFF2E7D32);
            } else if (status == "Sick") {
              icon = Icons.warning_rounded;
              statusColor =
                  isDark ? const Color(0xFFF44336) : const Color(0xFFC62828);
            } else {
              icon = Icons.medical_services_rounded;
              statusColor =
                  isDark ? const Color(0xFFFF9800) : const Color(0xFFE65100);
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? statusColor.withOpacity(0.12)
                      : (isDark
                          ? const Color(0xFF2A2420)
                          : const Color(0xFFF5EDE0)),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? statusColor.withOpacity(0.4)
                        : (isDark
                            ? const Color(0xFF3D362F)
                            : const Color(0xFFE8DCC8)),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedFilter = status;
                      });
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? statusColor.withOpacity(0.15)
                                  : (isDark
                                      ? const Color(0xFF1F1B18)
                                      : Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              icon,
                              color: statusColor,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              status,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: isSelected
                                    ? statusColor
                                    : (isDark
                                        ? const Color(0xFFD4C4A8)
                                        : const Color(0xFF4A3F2E)),
                              ),
                            ),
                          ),
                          if (isSelected)
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: statusColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(
                        color: isDark
                            ? const Color(0xFF3D362F)
                            : const Color(0xFFE8DCC8),
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? const Color(0xFF9C8B75)
                            : const Color(0xFF6B5F51),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isDark
                            ? [
                                const Color(0xFFE29B4B),
                                const Color(0xFFD67D2E),
                              ]
                            : [
                                const Color(0xFFD4956F),
                                const Color(0xFFB87333),
                              ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: (isDark
                                  ? const Color(0xFFE29B4B)
                                  : const Color(0xFFB87333))
                              .withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          widget.onFilterChanged(selectedFilter);
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.check_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Apply Filter",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 24),
        ],
      ),
    );
  }
}
