import 'dart:ui';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navBarColor = Colors.black.withAlpha(100);

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: navBarColor,
            boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 10)],
          ),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              height: 72,
              indicatorColor: Colors.orangeAccent.withAlpha(100),
              labelTextStyle: WidgetStateProperty.all(
                theme.textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                ),
              ),
              iconTheme: WidgetStateProperty.all(
                const IconThemeData(size: 24, color: Colors.orangeAccent),
              ),
              backgroundColor: Colors.transparent,
            ),
            child: NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: onItemTapped,
              elevation: 0,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.book_outlined),
                  selectedIcon: Icon(Icons.book),
                  label: 'Dictionary',
                ),
                NavigationDestination(
                  icon: Icon(Icons.psychology_outlined),
                  selectedIcon: Icon(Icons.psychology),
                  label: 'Quiz',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
