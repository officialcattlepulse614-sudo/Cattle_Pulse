import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TemperatureMonitorScreen extends StatelessWidget {
  const TemperatureMonitorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        tr('temperature_monitor'),
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
