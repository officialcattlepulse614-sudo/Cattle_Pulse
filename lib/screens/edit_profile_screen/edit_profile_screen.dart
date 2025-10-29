import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController(text: "Admin User");
  final _emailController = TextEditingController(text: "admin@cattlepulse.com");

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('edit_profile')),
        backgroundColor:
            isDark ? const Color(0xFFE29B4B) : const Color(0xFFB87333),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: tr('name')),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: tr('email')),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(tr('profile_updated'))),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isDark ? const Color(0xFFE29B4B) : const Color(0xFFB87333),
                foregroundColor: Colors.white,
              ),
              child: Text(tr('save_changes')),
            )
          ],
        ),
      ),
    );
  }
}
