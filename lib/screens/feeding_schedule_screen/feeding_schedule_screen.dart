import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class FeedingScheduleScreen extends StatelessWidget {
  const FeedingScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        tr('feeding_schedule'),
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
