import 'package:flutter/material.dart';

class AutofeederScreen extends StatelessWidget {
  const AutofeederScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [HeaderWidget(), firstbutton()],
      ),
    );
  }
}

// Header Widget
class HeaderWidget extends StatelessWidget {
  HeaderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Move icon slightly to the right
              Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF1F1B18) //Dark Mode
                        : const Color(0xFFE6DAC6), //Light Mode

                    borderRadius: BorderRadius.circular(12), // rounded corners

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Icon(
                    Icons.eco,
                    size: 28,
                    color: isDark
                        ? const Color(0xFFE29B4B) // icon color for dark
                        : const Color(0xFFB87333), // icon color for light
                  ),
                ),
              ),

              const SizedBox(width: 12), // spacing between icon & text

              Text(
                "Let's Feed Your Cattle!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: isDark
                      ? const Color(0xFFF5E6C8)
                      : const Color(0xFF3B2E1A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class firstbutton extends StatelessWidget {
  const firstbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF333333),
        foregroundColor: Colors.white,
        elevation: 3,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
      ),
      child: const Text('First Button'),
    );
  }
}
