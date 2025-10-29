import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        tr('reports'),
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
