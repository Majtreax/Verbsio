import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  final String label;
  final double fontSize;

  const ScoreCard({required this.label, required this.fontSize, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(100),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.blueGrey.withAlpha(100), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(25, 96, 125, 139),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize * 0.75,
          color: Colors.orangeAccent,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
