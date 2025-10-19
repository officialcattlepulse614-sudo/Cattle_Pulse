import 'package:flutter/material.dart';

class CattleHealthScreen extends StatelessWidget {
  const CattleHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Cattle Health",
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
