import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;

  final List<Map<String, dynamic>> languages = [
    {"name": "English", "locale": const Locale('en')},
    {"name": "Urdu (اردو)", "locale": const Locale('ur')},
    {"name": "Punjabi (پنجابی)", "locale": const Locale('pa')},
    {"name": "Sindhi (سنڌي)", "locale": const Locale('sd')},
    {"name": "Pashto (پښتو)", "locale": const Locale('ps')},
    {"name": "Balochi (بلوچی)", "locale": const Locale('bal')},
    {"name": "Arabic (العربية)", "locale": const Locale('ar')},
    {"name": "Chinese (中文)", "locale": const Locale('zh')},
    {"name": "French (Français)", "locale": const Locale('fr')},
    {"name": "German (Deutsch)", "locale": const Locale('de')},
    {"name": "Spanish (Español)", "locale": const Locale('es')},
    {"name": "Russian (Русский)", "locale": const Locale('ru')},
    {"name": "Turkish (Türkçe)", "locale": const Locale('tr')},
    {"name": "Japanese (日本語)", "locale": const Locale('ja')},
    {"name": "Korean (한국어)", "locale": const Locale('ko')},
    {"name": "Italian (Italiano)", "locale": const Locale('it')},
    {"name": "Portuguese (Português)", "locale": const Locale('pt')},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🟢 AppBar removed completely
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 🔔 Notifications toggle
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: Text(tr('notifications')),
            subtitle: const Text("Enable or disable app notifications"),
            value: notificationsEnabled,
            onChanged: (value) {
              setState(() => notificationsEnabled = value);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    value
                        ? "Notifications Enabled"
                        : "Notifications Disabled",
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
          const Divider(),

          // 🌐 Language selector
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(tr('language')),
            subtitle: Text(
              "${context.locale.languageCode.toUpperCase()} "
              "(${_getLanguageName(context.locale.languageCode)})",
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _showLanguageDialog(context),
          ),
          const Divider(),

          // ℹ️ App info
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(tr('about_app')),
            subtitle: const Text("Version 1.0.0"),
          ),
        ],
      ),
    );
  }

  String _getLanguageName(String code) {
    final lang = languages.firstWhere(
      (lang) => lang["locale"].languageCode == code,
      orElse: () => {"name": "Unknown"},
    );
    return lang["name"];
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select Language"),
        content: SizedBox(
          height: 400,
          width: double.maxFinite,
          child: ListView.builder(
            itemCount: languages.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(languages[index]["name"]),
                onTap: () async {
                  await context.setLocale(languages[index]["locale"]);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "${languages[index]["name"]} selected!",
                        style: const TextStyle(fontFamily: 'Roboto'),
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
