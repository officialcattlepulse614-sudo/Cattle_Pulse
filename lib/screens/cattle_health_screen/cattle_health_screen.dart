import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CattleHealthScreen extends StatelessWidget {
  const CattleHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        tr('cattle_health'),
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
