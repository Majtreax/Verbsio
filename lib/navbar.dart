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
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.cached),
          label: 'Refresh',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.quiz_outlined),
          label: 'Quiz',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book_outlined),
          label: 'Dictionary',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.orangeAccent,
      backgroundColor: Colors.black,
      onTap: onItemTapped,
    );
  }
}
