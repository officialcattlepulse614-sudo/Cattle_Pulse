// about_screen.dart
import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            Text(
              'CattlePulse',
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Version 1.0.0\n\nCattlePulse is a smart livestock monitoring system designed to help farmers track health, temperature, humidity, and real-time statistics of their cattle.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Developed by:\nTech Innovators Lab',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.secondary),
            ),
          ],
        ),
      ),
    );
  }
}
