import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        tr('notifications'),
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
