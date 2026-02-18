import 'package:flutter/material.dart';
import 'package:cattle_pulse/screens/side_menu_screens/home_screen/cattle_management_screen/cattle_model.dart';
import 'package:cattle_pulse/screens/side_menu_screens/home_screen/cattle_management_screen/cattle_service.dart';

class DeleteCattleDialog extends StatefulWidget {
  final CattleModel cattle;

  const DeleteCattleDialog({super.key, required this.cattle});

  @override
  State<DeleteCattleDialog> createState() => _DeleteCattleDialogState();
}

class _DeleteCattleDialogState extends State<DeleteCattleDialog> {
  bool _isDeleting = false;
  final CattleService _service = CattleService();

  Future<void> _deleteCattle() async {
    setState(() => _isDeleting = true);

    final success = await _service.deleteCattle(widget.cattle.id);
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    if (!mounted) return;

    setState(() => _isDeleting = false);

    if (success) {
      Navigator.pop(context, true); // notify previous screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: isDark
              ? const Color(0xFF2A2420) // Dark
              : const Color(0xFFF0EBE3), // Light
          content: Text(
            'Cattle deleted successfully',
            style: TextStyle(
              color: isDark
                  ? const Color(0xFFF5E6C8) // Dark
                  : const Color(0xFF2C2416), // Light
            ),
          ),
          duration: const Duration(seconds: 2), // optional
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      backgroundColor: isDark
          ? const Color(0xFF2A2420) //Dark
          : const Color(0xFFF0EBE3), //light
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(
          color: isDark ? const Color(0xFF302518) : const Color(0xFFA89B85),
          width: 1.8,
        ),
      ),
      title: Text(
        'Delete Cattle',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isDark
              ? const Color(0xFFF5E6C8) // Dark
              : const Color(0xFF2C2416), // Light
        ),
      ),
      content: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Are you sure you want to delete ',
              style: TextStyle(
                fontSize: 14,
                color: isDark
                    ? const Color(0xCEF5E6C8) // Dark
                    : const Color(0xFF2C2416), // Light
              ), // normal text
            ),
            TextSpan(
              text: '"${widget.cattle.name}"',
              style: TextStyle(
                fontSize: 16, // slightly bigger
                fontWeight: FontWeight.bold,
                color: isDark
                    ? const Color(0xFFF5E6C8) // Dark
                    : const Color(0xFF2C2416), // Light
              ),
            ),
            const TextSpan(
              text: '?\nThis action cannot be undone.',
              style: TextStyle(fontSize: 14), // normal text
            ),
          ],
        ),
      ),
      actions: [
        // Cancel Button
        ElevatedButton(
          onPressed: _isDeleting ? null : () => Navigator.pop(context, false),
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark
                ? const Color(0xFF2A2420) // Dark background
                : const Color(0xFFF0EBE3), // Light background
          ),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: isDark
                  ? const Color(0xFFF5E6C8) // Dark text
                  : const Color(0xFF2C2416), // Light text
            ),
          ),
        ),

        // Delete Button
        ElevatedButton(
          onPressed: _isDeleting ? null : _deleteCattle,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: _isDeleting
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('Delete'),
        ),
      ],
    );
  }
}
