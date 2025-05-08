import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:PV/widgets/navbar.dart';
import 'package:PV/dictionary.dart';
import 'package:PV/quiz.dart';

const BoxDecoration globalBackgroundDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xff4e3a7d),
      Color(0xff6f4aa5),
      Color(0xff9c6dc2),
      Color(0xffcda4de),
      Color(0xffe9d8f7),
    ],
  ),
);

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.black.withAlpha(100),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: Colors.orangeAccent, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: globalBackgroundDecoration,
        alignment: Alignment.center,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: pageContent,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 10)],
        ),
        child: BottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
