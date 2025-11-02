import 'package:flutter/material.dart';

/// ScreenWrapper paints the app-wide gradient (matching main.dart).
/// If [backgroundColor] is provided, it will draw that solid color on top
/// of the gradient (useful for a solid look). By default it shows the
/// global gradient so every screen matches.
class ScreenWrapper extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor; // optional override for a solid look
  final EdgeInsetsGeometry padding;

  const ScreenWrapper({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  LinearGradient _globalGradient(bool isDark) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark
          ? const [
              Color(0xFF000000),
              Color(0xFF111111),
              Color(0xFF0A0A0A),
            ]
          : const [
              Color(0xFFFFF8E7),
              Color(0xFFEAD9B0),
              Color(0xFFD1B585),
            ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      // Paint the app-wide gradient as the base
      decoration: BoxDecoration(
        gradient: _globalGradient(isDark),
      ),
      width: double.infinity,
      height: double.infinity,
      // If caller wants a solid color (override), paint it on top
      child: Container(
        color: backgroundColor ?? Colors.transparent,
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
