import 'package:flutter/material.dart';

import 'package:PV/widgets/navbar.dart';
import 'package:PV/dictionary.dart';
import 'package:PV/quiz.dart';
import 'package:PV/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    if (index != _selectedIndex) {
      setState(() => _selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String title = _selectedIndex == 0 ? 'Dictionary' : 'Quiz';
    final IconData icon = _selectedIndex == 0 ? Icons.book : Icons.psychology;
    final Widget pageContent =
        _selectedIndex == 0 ? const DictionaryPage() : const QuizPage();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.orangeAccent),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: globalBackgroundDecoration,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
            child: pageContent,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
